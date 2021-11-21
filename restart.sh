#!/usr/bin/env bash

pkill -f corelian_campaign
nohup ruby app/corelian_campaign.rb -o 0.0.0.0 &