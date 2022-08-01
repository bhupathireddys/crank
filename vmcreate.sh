#!/bin/bash
resourcegroup="workloads"
location="eastus"
vnet="workloads-vnet"
subnet="subnet1"
admin="sangabattula"
adminpasswd="Password123!"
image="Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest"
tags="Performance-Dotnet"
mynsg="main-wl-ports"
size="Standard_D4s_v5"

array=(loadgen 4appvm dbhost controller)
for vm in "${array[@]}"
do

az vm create --resource-group $resourcegroup --name $vm --image $image --admin-username $admin --admin-password $adminpasswd --location $location --size $size --vnet-name $
vnet --subnet $subnet --nsg $mynsg --accelerated-networking true --public-ip-address ""
done
