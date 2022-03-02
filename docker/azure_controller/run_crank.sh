#!/bin/bash

platformConfig=https://raw.githubusercontent.com/aspnet/Benchmarks/master/scenarios/platform.benchmarks.yml
plaintextConfig=https://raw.githubusercontent.com/aspnet/Benchmarks/master/scenarios/plaintext.benchmarks.yml
jsonConfig=https://raw.githubusercontent.com/aspnet/Benchmarks/master/scenarios/json.benchmarks.yml
databaseConfig=https://raw.githubusercontent.com/aspnet/Benchmarks/master/scenarios/database.benchmarks.yml
serverProfiles=/app/azure.profiles.yml
dataPath=/app/data/
for host in d4sv4 d4sv5 d8sv4 d8sv5 d16sv4 d16sv5 d32sv4 d32sv5 d48sv4 d48sv5 d64sv4 d64sv5 
do
for iter in 1 2 3
do

/app/crank --config "$platformConfig" --config "$serverProfiles" --scenario json --profile "$host" --application.framework net6.0 --json "$dataPath"/JSONplatform_"$host"_Itr"$iter"_Run.json --iterations "$iter"
/app/crank --config "$jsonConfig" --config "$serverProfiles" --scenario json --profile "$host" --application.framework net6.0 --json "$dataPath"/JSON_"$host"_Itr"$iter"_Run.json --iterations "$iter"
/app/crank --config "$jsonConfig" --config "$serverProfiles" --scenario https --profile "$host" --application.framework net6.0 --json "$dataPath"/JSONHTTPS_"$host"_Itr"$iter"_Run.json --iterations "$iter"
/app/crank --config "$platformConfig" --config "$serverProfiles" --scenario plaintext --profile "$host" --application.framework net6.0 --json "$dataPath"/PlaintextPlatform_"$host"_Itr"$iter"_Run.json --iterations "$iter"
/app/crank --config "$plaintextConfig" --config "$serverProfiles" --scenario plaintext --profile "$host" --application.framework net6.0 --json "$dataPath"/Plaintext_"$host"_Itr"$iter"_Run.json --iterations "$iter"

#Database required tests
/app/crank --config "$databaseConfig" --config "$serverProfiles" --scenario fortunes --profile "$host" --application.framework net6.0 --json "$dataPath"/Fortunes_"$host"_Itr"$iter"_Run.json --iterations "$iter"
/app/crank --config "$platformConfig" --config "$serverProfiles" --scenario fortunes --profile "$host" --application.framework net6.0 --json "$dataPath"/Fortuneslatform_"$host"_Itr"$iter"_Run.json --iterations "$iter"

done;
done