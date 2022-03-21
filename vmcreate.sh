resourcegroup="bsdotnet"
location="eastus"
vnet="BSDotNetvNet"
subnet="subnet1"
admin="admin"
adminpasswd="Password123!"
image="Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest"
tags="Performance=Dotnet"
mynsg="BSDotNet"
size="Standard_D8s_v4"

for vm in d4sv4 d4sv5 d8sv4 d8sv5
do

az vm create --resource-group $resourcegroup --name $vm --image $image --admin-username $admin --admin-password $adminpasswd --location $location --size $size --vnet-name $
vnet --subnet $subnet --nsg $mynsg --accelerated-networking true --public-ip-address ""
done