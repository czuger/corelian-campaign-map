#!/bin/bash

cd ..

scp -r corelian-campaign-map/models cloud_ovh:~/ruby/corelian-campaign-map/
scp -r corelian-campaign-map/db cloud_ovh:~/ruby/corelian-campaign-map/
scp corelian-campaign-map/* cloud_ovh:~/ruby/corelian-campaign-map/
