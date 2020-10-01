#!/bin/bash

gcloud beta compute instances create blue --zone=us-central1-a --tags=web-server 
gcloud beta compute instances create green --zone=us-central1-a 

gcloud beta compute ssh --zone "us-central1-a" "blue" --quiet --command="sudo apt-get install nginx-light -y"

gcloud beta compute ssh --zone "us-central1-a" "green" --quiet --command="sudo apt-get install nginx-light -y"

export GOOGLE_CLOUD_PROJECT=$(gcloud info \
    --format='value(config.project)')

gcloud iam service-accounts create network-admin --display-name "Network-admin"

# gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
#     --member serviceAccount:network-admin@$GOOGLE_CLOUD_PROJECT.iam.gserviceaccount.com --role roles/compute.networkAdmin

gcloud compute firewall-rules create allow-http-web-server --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80,icmp --source-ranges=0.0.0.0/0 --target-tags=web-server

gcloud compute instances create test-vm --machine-type=f1-micro --subnet=default --zone=us-central1-a


