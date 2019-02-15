#!/bin/bash

echo "Give Payment Method Code[]:"
read code
echo "Give Payment Table Code[like:cod_gebr_]:"
read tablecode
echo "Give Payment Method Title[In storefront this will be displayed by def. can be changed later]:"
read title
echo "Limit to which shipping methods[like:gebruderSzallito_1]:"
read methods

#cd toCopy

if [ ! -d "/CashOnDelivery" ]; then
git clone https://github.com/ZFYL/CashOnDelivery.git
fi

cp -r CashOnDelivery/ ../$code/

cd ../$code

print $code

find -name "CashOnDelivery*" -exec rename "s/CashOnDelivery/$code/" {} ";"

find . -type f -exec sed -i "s/gebruderSzallito_1/$methods/g" {} +

find . -type f -exec sed -i "s/CashOnDelivery/$code/g" {} +

find . -type f -exec sed -i "s/msp_cashondelivery/$code/g" {} +

find . -type f -exec sed -i "s/Cash On Delivery - MageSpecialist codder/$title/g" {} +

find . -type f -exec sed -i "s/Cash on delivery codder/$title/g" {} +

find . -type f -exec sed -i "s/name=\"msp\"/name=\"$code\"/g" {} +

find . -type f -exec sed -i "s/msp_cod_/$tablecode/g" {} +

cd ../../../../

/usr/local/php71/bin/php -f bin/magento module:enable MSP_$code

/usr/local/php71/bin/php -f bin/magento setup:upgrade
