#!/bin/bash

while [[ -z "$(gcloud config get-value core/account)" ]]; 
do echo "waiting login" && sleep 2; 
done

while [[ -z "$(gcloud config get-value project)" ]]; 
do echo "waiting project" && sleep 2; 
done


gcloud beta compute instances create green --zone=us-central1-a 

gcloud beta compute ssh --zone "us-central1-a" "green" --quiet --command="sudo apt-get install nginx-light -y"

gcloud compute instances create test-vm --machine-type=f1-micro --subnet=default --zone=us-central1-a
