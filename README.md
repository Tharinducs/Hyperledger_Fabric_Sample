[//]: # (SPDX-License-Identifier: CC-BY-4.0)

## About Project

This is sample Hyperledger Fabric blockahain Application. Which contains two organizations as

<ol>
    <li>Doctor</li>
    <li>Generalpublic(Patient)</li>
</ol>

This will be containing the project upto building a frontend using ReactJs and Nodejs.

## Getting Start

Clone this repository by Issuing following command In terminal

`git clone https://github.com/Tharinducs/Hyperledger_Fabric_Sample.git`

## Creating channel artifacts and crypto-materials

Then go inside Hyperledger_Fabric_Sample folder

`cd Hyperledger_Fabric_Sample`

Open this folder in your text editor I prefer #Visual Studio code.

Then open a terminal inside Hyperledger_Fabric_Sample/pmschainsolo.

Then create two folders inside pmschainsolo folder as following
    <ul>
    <li>channel-artifacts</li>
    <li>crypto-config</li>
    </ul>

Then Run generate.sh file using this command.

`./generate.sh`

Now You will have all the binaries inside channel-artifacts and cryto-config folders.

<i>If you need to increse the ammount of organizations you have to edit the crypto-config.yaml, configtx.yaml file according to your requirements.If you increse the ammout of organizations you have to change generate.sh file accordingly.I will have some articles on Medium how we can do this and complete explanation about commands in generate.sh file.You can follow me on Medium to get in touch with those. <a href="https://medium.com/@tharindusandaruwan40">Tharindu Sandaruwan<a> <i>


## Creting the network

For that  open this file pmschainsolo/docker-compose-cli.yaml.

Then edit folowing areas.

`- FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server-config/ce9da2b3c37d18b04361afdfb2f65dd892157cdabacd4fb86dc7dd0cd488fa98_sk`
` command: sh -c 'fabric-ca-server start --ca.certfile /etc/hyperledger/fabric-ca-server-config/ca.generalpublic.pms.com-cert.pem --ca.keyfile /etc/hyperledger/fabric-ca-server-config/ce9da2b3c37d18b04361afdfb2f65dd892157cdabacd4fb86dc7dd0cd488fa98_sk -b admin:adminpw -d'`

This file name ends with _sk should rename accroding to the genearted ca-cerver-congigurations keys generated in previous step for both organizations.

The ca-sever-config file path for both organization is here.

`pmschainsolo/crypto-config/peerOrganizations/doctor.pms.com/ca/......_sk`
`pmschainsolo/crypto-config/peerOrganizations/generalpublic.pms.com/ca/......_sk`

<i>If you have increse the number of peers then you have to change following files accordingly.

<ul>
    <li>pmschainsolo/base/docker-compose-base.yaml</li>
    <li>pmschainsolo/docker-compose-cli.yaml</li>
    <li>pmschainsolo/docker-compose-couch.yaml</li>
</ul>
</i>

Now you setup all your configuration for your blockhain network.

## Running your Network

Now run startNetwork.sh file by issuing this command on terminal.

`./startNetwork.sh`

<b>If you have anything running on docker other than Hyperledger Fabric please be carefull when running this command.If somthing running remove volumes and containers only related to hyperledger fabric and remove following lines from Hyperledger Fabric

`#removing all the containers
echo ""
echo "##### Removing all the containers #####"
echo ""
echo ""
docker rm -f $(docker ps -aq)
echo ""
echo ""

#prune the volumes
echo "#### Prune the network #####"
echo ""
echo ""
docker volume prune
echo ""
echo ""

#down the previously build networks
echo "##### Removing networks #####" 
echo ""
echo ""
docker network prune
echo ""
echo ""

#down the previously build networks
echo "##### Clearing the System #####" 
echo ""
echo ""
docker system prune
echo ""
echo ""`

</b>

After suucessfully running that file Issue commands in clicommandreference file one by one.

Now you Have run a sample network using Hyperledgr Fabric.



