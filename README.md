# How to update imx8mx-CM7 SDK environment

To update the imx8mn and imx8mp SDK versions, follow these steps:
- ## A) Update imx8mn SDK:
    1. Checkout the vendor/imx8mn branch.
    2. Execute the command: `./scripts/import-sdk imx8mn <sdk-x-x-x*mn.tar.gz>`.
    3. Commit the changes made.
    4. merge changes into master branch.
- ## B) Update imx8mp SDK:
    1. Checkout the vendor/imx8mp branch.
    2. Execute the command: `./scripts/import-sdk imx8mp <sdk-x-x-x*mp.tar.gz>`.
    3. Commit the changes made.
    4. merge changes into master branch.
