




























Bash command to copy COD
create dir 'toCopy' under app/code/MSP
cd toCopy
git clone https://github.com/ZFYL/CashOnDelivery.git
cp -r CashOnDelivery/ ../cod1
cp -r CashOnDelivery/ ../cod2
cp -r CashOnDelivery/ ../cod3
..
cp -r CashOnDelivery/ ../cod[n]

n times repeat


#!/bin/bash

echo "Give Payment Method Code:"
read code
echo "Give Payment Method Title:"
read title
echo "Limit to which shipping methods:"
read methods

cd toCopy
git clone https://github.com/ZFYL/CashOnDelivery.git
cp -r CashOnDelivery/ ../$code

cd ../$code

find -name "CashOnDelivery.*" -exec rename 's/CashOnDelivery/$code/' {} ";"

find . -type f -exec sed -i 's/gebruderSzallito_1/$methods/g' {} +

find . -type f -exec sed -i 's/CashOnDelivery/$code/g' {} +

find . -type f -exec sed -i 's/msp_cashondelivery/$code/g' {} +

find . -type f -exec sed -i 's/Cash On Delivery - MageSpecialist codder/$title/g' {} +

find . -type f -exec sed -i 's/Cash on delivery codder/$title/g' {} +

find . -type f -exec sed -i 's/name="msp_2"/name="$code"/g' {} +

cd ../../../../

/usr/local/php71/bin/php -f bin/magento module:enable MSP_$code

/usr/local/php71/bin/php -f bin/magento setup:upgrade





Store -> Configuration -> Sales -> Payment Methods
Enable Module
Upload your rules csv

DONE
