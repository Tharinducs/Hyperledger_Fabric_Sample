export FABRIC_CFG_PATH=$PWD
echo $FABRIC_CFG_PATH
export PATH=${PWD}/../bin:${PWD}:$PATH
export VERBOSE=false
CHANNEL_NAME=pmschannel


# remove previous crypto material
rm -fr crypto-config/*

# remove previous crypto material
cd channel-artifacts
rm -f *
cd ../

# # generate crypto material
echo " "
echo "############################ Generating Crypto materiels ######################"
echo " "
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

# generate genesis block for orderer
echo " "
echo "############################ Generating genesis block ######################"
echo " "
configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi

# generate channel configuration transaction
echo " "
echo "###################### Generating channel.tx ##########################"
echo " "
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

echo " "
echo "##################### Generating Anchor peer update for GeneralpublicMSP #####################"
echo " "
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/GeneralpublicMSPanchors.tx -channelID $CHANNEL_NAME -asOrg GeneralpublicMSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for GeneralpublicMSP..."
  exit 1
fi

echo " "
echo "##################### Generating Anchor peer update for DoctorMSP #####################"
echo " "
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/DoctorMSPanchors.tx -channelID $CHANNEL_NAME -asOrg DoctorMSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for DoctorMSP..."
  exit 1
fi