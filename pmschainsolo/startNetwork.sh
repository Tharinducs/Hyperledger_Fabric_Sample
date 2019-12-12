# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

#removing all the containers
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
echo ""

#Up the network
echo "##### Network is under the build #####"
echo ""
echo ""
docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml up -d
echo ""
echo ""

# echo "##### Network is under the build #####"
# echo ""
# echo ""
# docker-compose -f docker-compose-cli.yaml up -d
# echo ""
# echo ""

#starting the cli
echo ""
echo ""
echo "##### Starting the cli incase if it is sleep #####"
docker start cli
echo ""
echo ""


#creating the channel
echo ""
echo ""
echo "##### Creating the channel #####"
echo ""
docker exec -e "CORE_PEER_LOCALMSPID=DoctorMSP" -e "CORE_PEER_MSPCONFIGPATH=//opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/doctor.pms.com/users/Admin@doctor.pms.com/msp" -e "CORE_PEER_ADDRESS=peer0.doctor.pms.com:9051" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/doctor.pms.com/peers/peer0.doctor.pms.com/tls/ca.crt" cli peer channel create -o orderer.pms.com:7050 -c pmschannel -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/pms.com/orderers/orderer.pms.com/msp/tlscacerts/tlsca.pms.com-cert.pem
if [ "$?" -ne 0 ]; then
  echo "Channel Creation Failed...."
  exit 1
fi
echo ""
echo ""







