#!/bin/bash



# TODO: why is the alias not working?
kk='~/Work/docs/scripts/ruby/kmd-local'

bash -c "$kk refresh-env -- local falkor no-confirm"
bash -c "$kk refresh-env -- local admin-auth no-confirm"
bash -c "$kk refresh-env -- local admin-web no-confirm"
bash -c "$kk refresh-env -- local auth no-confirm"
bash -c "$kk refresh-env -- local billing no-confirm"
bash -c "$kk refresh-env -- local graphql no-confirm"
bash -c "$kk refresh-env -- local membership no-confirm"
bash -c "$kk refresh-env -- local metric no-confirm"
bash -c "$kk refresh-env -- local notify no-confirm"
bash -c "$kk refresh-env -- local social no-confirm"
bash -c "$kk refresh-env -- local user no-confirm"
bash -c "$kk refresh-env -- local hub no-confirm"


#cat ~/Work/docs/configs/convox-env/falkor-game-service.txt | convox env set --app=falkor-game-service
# cat ~/Work/docs/configs/convox-env/wb-admin-auth-service.txt | convox env set --app=wb-admin-auth-service
#cat ~/Work/docs/configs/convox-env/wb-admin-web.txt | convox env set --app=wb-admin-web
# cat ~/Work/docs/configs/convox-env/wb-auth-service.txt | convox env set --app=wb-auth-service
# cat ~/Work/docs/configs/convox-env/wb-billing-service.txt | convox env set --app=wb-billing-service
# cat ~/Work/docs/configs/convox-env/wb-graphql-service.txt | convox env set --app=wb-graphql-service
# cat ~/Work/docs/configs/convox-env/wb-membership-service.txt | convox env set --app=wb-membership-service
# cat ~/Work/docs/configs/convox-env/wb-metric-service.txt | convox env set --app=wb-metric-service
# cat ~/Work/docs/configs/convox-env/wb-notify-service.txt | convox env set --app=wb-notify-service
# cat ~/Work/docs/configs/convox-env/wb-social-service.txt | convox env set --app=wb-social-service
# cat ~/Work/docs/configs/convox-env/wb-user-service.txt | convox env set --app=wb-user-service




#cat ~/Work/docs/configs/convox-env/wb-hub.txt | convox env set --app=wb-hub
# cp -f -v ~/Work/docs/configs/convox-env/wb-hub.txt ~/Work/wb-services/wb-hub/.env
