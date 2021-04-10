#!/bin/bash

# TODO : revoir le déploiement on écrase la base

scp -r models cloud_ovh:~/ruby/corelian-campaign-map/
scp -r db/migrate cloud_ovh:~/ruby/corelian-campaign-map/db/
scp app.rb cloud_ovh:~/ruby/corelian-campaign-map/
