#!/bin/bash



# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT



if ! [ -x "$(command -v ruby)" ]; then
	sudo ~/Work/docs/scripts/installs/install-ruby.sh
	reloadaliases
else
  echo 'Ruby 2.6.2 is already installed. Skipping.'
fi

# TODO: why is the alias not working?
kk='/home/dev/Work/docs/scripts/ruby/kmd-local'

# TODO : why is this setting always off?
eval "$(rbenv init -)"
rbenv shell 2.6.2


sudo echo 'fixing iptables' && sudo iptables -P FORWARD ACCEPT && echo 'done'
convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod)


if test -d "${HOME}/Work/wb-services/falkor-game-service"; then
	if ! [[ $(convox apps) =~ 'falkor-game-service' ]]; then
		echo "Creating falkor-game-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/falkor-game-service"
		convox apps create falkor-game-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local falkor
		$kk refresh-env -- local falkor no-confirm
		convox build -m convox.local.yml
	else
	  echo 'falkor-game-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-membership-service"; then
	if ! [[ $(convox apps) =~ 'wb-membership-service' ]]; then
		echo "Creating wb-membership-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-membership-service"
		convox apps create wb-membership-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local membership
		$kk refresh-env -- local membership no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-membership-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-user-service"; then
	if ! [[ $(convox apps) =~ 'wb-user-service' ]]; then
		echo "Creating wb-user-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-user-service"
		convox apps create wb-user-service

		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local user
		$kk refresh-env -- local user no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-user-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-auth-service"; then
	if ! [[ $(convox apps) =~ 'wb-auth-service' ]]; then
		echo "Creating wb-auth-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-auth-service"
		convox apps create wb-auth-service
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local auth
		$kk refresh-env -- local auth no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-auth-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-admin-auth-service"; then
	if ! [[ $(convox apps) =~ 'wb-admin-auth-service' ]]; then
		echo "Creating wb-admin-auth-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-admin-auth-service"
		convox apps create wb-admin-auth-service
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local admin-auth
		$kk refresh-env -- local admin-auth no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-admin-auth-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-billing-service"; then
	if ! [[ $(convox apps) =~ 'wb-billing-service' ]]; then
		echo "Creating wb-billing-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd  "${HOME}/Work/wb-services/wb-billing-service"
		convox apps create wb-billing-service
		git reset --hard
		git clean -f
		git pull

		$kk refresh-yml -- local billing
		$kk refresh-env -- local billing no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-billing-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-notify-service"; then
	if ! [[ $(convox apps) =~ 'wb-notify-service' ]]; then
		echo "Creating wb-notify-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-notify-service"
		convox apps create wb-notify-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local notify
		$kk refresh-env -- local notify no-confirm
		convox build -m convox.local.yml
	else 
	  echo 'wb-notify-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-social-service"; then
	if ! [[ $(convox apps) =~ 'wb-social-service' ]]; then
		echo "Creating wb-social-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-social-service"
		convox apps create wb-social-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local social
		$kk refresh-env -- local social no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-social-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-metric-service"; then
	if ! [[ $(convox apps) =~ 'wb-metric-service' ]]; then
		echo "Creating wb-metric-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-metric-service"
		convox apps create wb-metric-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local metric
		$kk refresh-env -- local metric no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-metric-service app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-admin-web"; then
	if ! [[ $(convox apps) =~ 'wb-admin-web' ]]; then
		echo "Creating wb-admin-web app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-admin-web"
		convox apps create wb-admin-web
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local ninja
		$kk refresh-env -- local ninja no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-admin-web app already exists. Skipping.'
	fi
fi

if test -d "${HOME}/Work/wb-services/wb-graphql-service"; then
	if ! [[ $(convox apps) =~ 'wb-graphql-service' ]]; then
		echo "Creating wb-graphql-service app"
		echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
		sleep 3s

		cd "${HOME}/Work/wb-services/wb-graphql-service"
		convox apps create wb-graphql-service
		git reset --hard
		git clean -f
		git pull
		$kk refresh-yml -- local graphql
		$kk refresh-env -- local graphql no-confirm
		convox build -m convox.local.yml
	else
	  echo 'wb-graphql-service app already exists. Skipping.'
	fi
fi
