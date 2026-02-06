#!/bin/bash


# TODO: why is the alias not working?
kk='~/Work/docs/scripts/ruby/kmd-local'

# bash -c "$kk refresh-yml -- local falkor"
# bash -c "$kk refresh-yml -- local runbet"
# bash -c "$kk refresh-yml -- local quitbet"
# bash -c "$kk refresh-yml -- local admin-auth"
# bash -c "$kk refresh-yml -- local admin-web"
# bash -c "$kk refresh-yml -- local billing"
# bash -c "$kk refresh-yml -- local graphql"
# # bash -c "$kk refresh-yml -- local hub"
# bash -c "$kk refresh-yml -- local membership"
# bash -c "$kk refresh-yml -- local metric"
# bash -c "$kk refresh-yml -- local notify"
# bash -c "$kk refresh-yml -- local social"
# bash -c "$kk refresh-yml -- local user"

cp -f -v ~/Work/docs/local-settings/convox-yml/falkor-game-service.convox.local.yml ~/Work/wb-services/falkor-game-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/runbet-game-service.convox.local.yml ~/Work/wb-services/runbet-game-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-admin-auth-service.convox.local.yml ~/Work/wb-services/wb-admin-auth-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-admin-web.convox.local.yml ~/Work/wb-services/wb-admin-web/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-auth-service.convox.local.yml ~/Work/wb-services/wb-auth-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-billing-service.convox.local.yml ~/Work/wb-services/wb-billing-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-graphql-service.convox.local.yml ~/Work/wb-services/wb-graphql-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-hub.convox.local.yml ~/Work/wb-services/wb-hub/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-membership-service.convox.local.yml ~/Work/wb-services/wb-membership-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-metric-service.convox.local.yml ~/Work/wb-services/wb-metric-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-notify-service.convox.local.yml ~/Work/wb-services/wb-notify-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-social-service.convox.local.yml ~/Work/wb-services/wb-social-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-user-service.convox.local.yml ~/Work/wb-services/wb-user-service/convox.local.yml
cp -f -v ~/Work/docs/local-settings/convox-yml/wb-user-service.convox.local.yml ~/Work/wb-services/wb-user-service/convox.local.yml
