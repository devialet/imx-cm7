#include "fsl_device_registers.h"
#include "fsl_debug_console.h"
#include "fsl_ecspi.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "board.h"
#include "xmos_image.h"
#include "fsl_gpio.h"

/*******************************************************************************
 * Definitions
 ******************************************************************************/
#define ECSPI_MASTER_BASEADDR ECSPI2
#define ECSPI_DEALY_COUNT     10000000U
#define ECSPI_MASTER_CLK_FREQ                                                                 \
    (CLOCK_GetPllFreq(kCLOCK_SystemPll1Ctrl) / (CLOCK_GetRootPreDivider(kCLOCK_RootEcspi2)) / \
     (CLOCK_GetRootPostDivider(kCLOCK_RootEcspi2)))
#define TRANSFER_SIZE     xmos_array_size     /*! Transfer dataSize */
#define TRANSFER_BAUDRATE 500000U /*! Transfer baudrate - 500k */

#define SPI_GPIO     GPIO5
#define GPIO_RST_PIN 8U
#define GPIO_SS_PIN 9U

int main(void)
{
    gpio_pin_config_t spi_gpio_config = {kGPIO_DigitalOutput, 1, kGPIO_NoIntmode};

    BOARD_InitMemory();

    /* Board specific RDC settings */
    BOARD_RdcInit();

    BOARD_InitBootPins();
    BOARD_BootClockRUN();
    BOARD_InitDebugConsole();

    CLOCK_SetRootMux(kCLOCK_RootEcspi2, kCLOCK_EcspiRootmuxSysPll1); /* Set ECSPI2 source to SYSTEM PLL1 800MHZ */
    CLOCK_SetRootDivider(kCLOCK_RootEcspi2, 2U, 5U);                 /* Set root clock to 800MHZ / 10 = 80MHZ */

    GPIO_PinInit(SPI_GPIO, GPIO_RST_PIN, &spi_gpio_config);
    GPIO_PinInit(SPI_GPIO, GPIO_SS_PIN, &spi_gpio_config);

    ecspi_master_config_t masterConfig;
    ecspi_transfer_t masterXfer;

    PRINTF("init SPI.\r\n");
    ECSPI_MasterGetDefaultConfig(&masterConfig);
    masterConfig.baudRate_Bps = TRANSFER_BAUDRATE;
    masterConfig.burstLength = 32;
    ECSPI_MasterInit(ECSPI_MASTER_BASEADDR, &masterConfig, ECSPI_MASTER_CLK_FREQ);
    masterXfer.txData   = xmos_array;
    masterXfer.rxData   = NULL;
    masterXfer.dataSize = TRANSFER_SIZE;
    masterXfer.channel  = kECSPI_Channel0;
    GPIO_PinWrite(SPI_GPIO, GPIO_SS_PIN, 1U);

    PRINTF("reset.\r\n");
    GPIO_PinWrite(SPI_GPIO, GPIO_RST_PIN, 0U);
    SDK_DelayAtLeastUs(1000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
    GPIO_PinWrite(SPI_GPIO, GPIO_RST_PIN, 1U);
    SDK_DelayAtLeastUs(10000, SDK_DEVICE_MAXIMUM_CPU_CLOCK_FREQUENCY);
    PRINTF("reset-done.\r\n");

    PRINTF("boot XMOS.\r\n");
    GPIO_PinWrite(SPI_GPIO, GPIO_SS_PIN, 0U);
    ECSPI_MasterTransferBlocking(ECSPI_MASTER_BASEADDR, &masterXfer);
    GPIO_PinWrite(SPI_GPIO, GPIO_SS_PIN, 1U);
}
