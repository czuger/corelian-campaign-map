#!/bin/bash

# TODO : revoir le déploiement on écrase la base

scp -r app cloud_ovh:~/ruby/corelian-campaign-map/
scp -r db/migrate cloud_ovh:~/ruby/corelian-campaign-map/db/

scp .ruby-version cloud_ovh:~/ruby/corelian-campaign-map/
scp Gemfile cloud_ovh:~/ruby/corelian-campaign-map/
scp Gemfile.lock cloud_ovh:~/ruby/corelian-campaign-map/
scp Rakefile cloud_ovh:~/ruby/corelian-campaign-map/