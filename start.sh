#!/bin/bash

docker-compose up -d node1 node2 node3 node4 

echo "=============================== Starting Network ==================================="

sleep 15

docker-compose up -d  webserver

# docker-compose up -d  tails  


# echo "=============================== Utils are created ==================================="

docker-compose up -d wallet-db
# sleep 10

docker-compose up -d  MT-users issuer verifier  

echo "=============================== Agents are created ==================================="


docker-compose up -d mongo mongo-express


echo "===============================Starting Mongo DB ==================================="

echo "===============================Sleeping 30 seconds==================================="
sleep 30

createWallet() {
    echo $port
    res=$(curl -X POST -H "Content-Type: application/json" http://localhost:$port/wallet/did/create)
    echo $res
    echo "===============================Wallet Created==================================="
}
issuerId="test"
getWallet() {
    did=$(curl -X GET "http://localhost:$port/wallet/did" -H  "accept: application/json" | jq -r '.results[0].did')
    issuerId="$did"
    export issuerId 
    # echo "Updated issuerId: $issuerId"
    verkey=$(curl -X GET "http://localhost:$port/wallet/did" -H  "accept: application/json" | jq -r '.results[0].verkey')
}

registerWallet() {
    res=$(curl -X POST -H "Content-Type: application/json" -d '{"did":"'"$did"'","verkey":"'"$verkey"'"}' http://localhost:9000/register)
    echo $res
    echo "===============================Wallet Registered==================================="
}

assignPublicDid() {
    res=$(curl -X POST "http://localhost:$port/wallet/did/public?did=${did}" -H  "accept: application/json")
    echo $res
    echo "===============================Assigned Public DID==================================="
}

registerSchema() {
    echo $schema
    res=$(curl -X POST "http://localhost:$port/anoncreds/schema" -H  "accept: application/json" -H  "Content-Type: application/json" -d "$schema")
    echo $res
    schema_id=$(echo "$res" | jq -r '.schema_state.schema_id')
    echo "===============================Schema Registered Successfully==================================="
}

# getSchema() {
#     echo "http://localhost:$port/anoncreds/schema/${schema_name}"
#     # schema_id=$(curl -X GET "http://localhost:$port/anoncreds/schema/created?schema_name=${schema_name}" -H  "accept: application/json" | jq -r '.schema_ids[0]')
#     schema_id=$(curl -X GET "http://localhost:$port/anoncreds/schema/${schema_name}" -H  "accept: application/json" | jq -r '.schema_ids[0]')
# }


registerCredentialDefinition() {
    echo '{"credential_definition": { "issuerId": "'"$issuerId"'", "schemaId": "'"$schema_id"'",   "tag": "'"$creddeftag"'"}}'
    res=$(curl -X POST "http://localhost:$port/anoncreds/credential-definition" -H  "accept: application/json" -H  "Content-Type: application/json" -d '{"credential_definition": { "issuerId": "'"$did"'", "schemaId":"'"$schema_id"'",   "tag": "'"$creddeftag"'"}}')


    echo $res
    echo "===============================Credential Definition Registered Successfully==================================="
}


port=8021
schema_name='DLSchema'
creddeftag='DL_schema'

createWallet
sleep 5
getWallet
sleep 5
registerWallet
sleep 5
assignPublicDid
sleep 5
# schema='{"schema": {"attrNames": [ "name", "date", "degree", "birthdate_dateint", "timestamp"], "issuerId": "'"$issuerId"'", "name": "degreeSchema",  "version": "1.0"}}'
schema='{"schema": {"attrNames": [ "name", "address", "licenseClass", "birthdate_dateint", "expirydate_dateint"], "issuerId": "'"$issuerId"'", "name": "DLSchema",  "version": "1.0"}}'
echo $schema
registerSchema
sleep 5
# getSchema
# sleep 5
registerCredentialDefinition 


sleep 5

port=8031

createWallet
sleep 5
getWallet
sleep 5
registerWallet
sleep 5
assignPublicDid

echo "===============================Sleeping 20 seconds==================================="
sleep 20

echo "===============================Starting Backend & UI servers ==================================="

docker-compose -f docker-compose-backend-ui.yaml up -d

echo "===============================Setup Completed ==================================="
