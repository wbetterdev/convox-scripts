#!/bin/bash


# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT


if ! test -d "${HOME}/Work/wb-services"; then
	echo "Creating wb-service folder"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s
	mkdir ~/Work/wb-services
else
  echo 'wb-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/kraken"; then
	echo "Creating kraken folder"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/kraken.git kraken
else
  echo 'kraken folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-membership-service"; then
	echo "Cloning wb-membership-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-membership-service.git wb-membership-service
	cd ~/Work/wb-services/wb-membership-service
else
  echo 'wb-membership-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-user-service"; then
	echo "Cloning wb-user-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-user-service.git wb-user-service
	cd ~/Work/wb-services/wb-user-service
else
  echo 'wb-user-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-auth-service"; then
	echo "Cloning wb-auth-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-auth-service.git wb-auth-service
	cd ~/Work/wb-services/wb-auth-service
else
  echo 'wb-auth-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-admin-auth-service"; then
	echo "Cloning wb-admin-auth-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-admin-auth-service.git wb-admin-auth-service
	cd ~/Work/wb-services/wb-admin-auth-service
else
  echo 'wb-admin-auth-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-billing-service"; then
	echo "Cloning wb-billing-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-billing-service.git wb-billing-service
	cd ~/Work/wb-services/wb-billing-service
else
  echo 'wb-billing-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-notify-service"; then
	echo "Cloning wb-notify-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-notify-service.git wb-notify-service
	cd ~/Work/wb-services/wb-notify-service
else
  echo 'wb-notify-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-social-service"; then
	echo "Cloning wb-social-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-social-service.git wb-social-service
	cd ~/Work/wb-services/wb-social-service
else
  echo 'wb-social-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-metric-service"; then
	echo "Cloning wb-metric-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-metric-service.git wb-metric-service
	cd ~/Work/wb-services/wb-metric-service
else
  echo 'wb-metric-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-admin-web"; then
	echo "Cloning wb-admin-web from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-admin-web.git wb-admin-web
	cd ~/Work/wb-services/wb-admin-web
else
  echo 'wb-admin-web folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-graphql-service"; then
	echo "Cloning wb-graphql-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-graphql.git wb-graphql-service
	cd ~/Work/wb-services/wb-graphql-service
else
  echo 'wb-graphql-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/runbet-game-service"; then
	echo "Cloning runbet-game-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/runbet-game-service.git runbet-game-service
	cd ~/Work/wb-services/runbet-game-service
else
  echo 'runbet-game-service folder already exists. Skipping.'
fi


if ! test -d "${HOME}/Work/wb-services/quitbet-game-service"; then
	echo "Cloning quitbet-game-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/quitbet-game-service.git quitbet-game-service
	cd ~/Work/wb-services/quitbet-game-service
else
  echo 'quitbet-game-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/falkor-game-service"; then
	echo "Cloning falkor-game-service from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/falkor-game-service.git falkor-game-service
	cd ~/Work/wb-services/falkor-game-service
else
  echo 'falkor-game-service folder already exists. Skipping.'
fi

if ! test -d "${HOME}/Work/wb-services/wb-hub"; then
	echo "Cloning wb-hub from git"
	echo "Sleeping for 3 seconds. Click ctrl+C to abort script." 
	sleep 3s

	cd ~/Work/wb-services
	git clone git@github.com:wbetterdev/wb-hub.git wb-hub
	cd ~/Work/wb-services/wb-hub
else
  echo 'wb-hub folder already exists. Skipping.'
fi
