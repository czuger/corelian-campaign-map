#!/usr/bin/env bash

cd app
bundle exec rerun --pattern '**/*.rb' 'ruby corelian-campaign.rb'
