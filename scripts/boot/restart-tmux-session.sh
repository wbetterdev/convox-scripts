#!/bin/bash


#####################################################################
# Script that kill currect tmux session and creates it again (to safe CPU load due to convox bug)
# HOT TO INSTALL
# 1. run 'sudo crontab -e'
# 2. Add the following line  
#    0 */6 * * * env DISPLAY=:0 /usr/bin/xfce4-terminal --maximize -e 'bash -c "/home/dev/Work/docs/scripts/boot/restart-tmux-session.sh; exit 0"' -T "Local Convox"
# 3. Create folder /home/dev/tmux-boot-logs/ for logs
#####################################################################


# Ensure the environment is available
export HOME="/home/dev/"
export PATH="/home/dev/.rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:/home/dev/.nvm/versions/node/v10.16.3/bin:/home/dev/.rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:/home/dev/.rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:/home/dev/.rbenv/plugins/ruby-build/bin:/usr/local/rbenv/shims:/usr/local/rbenv/bin:/home/dev/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/dev/.local/bin:/home/dev/.local/bin:/home/dev/Work/docs/scripts/ruby:/home/dev/Work/docs/scripts/ruby:/home/dev/Work/wb-services/kraken/bin:/home/dev/Work/wb-services/kraken/bin"

source /home/dev/.bashrc
source /home/dev/.bash_aliases
source /home/dev/.profile

#echo $(date) + "Fixing DNS: "  >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
#convox registries add 247028141071.dkr.ecr.us-west-2.amazonaws.com AWS $(aws ecr get-login-password --region us-west-2 --profile prod) >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1

echo $(date) + ": killing old tmux session" >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
tmux kill-session -t lconvox >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1

echo $(date) + ": running wbtmux" >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
ruby /home/dev/Work/docs/scripts/ruby/wbtmux -r mysql,user,auth,bill,falkor,graphql,admin-auth,admin-web,metric,notify,member,social,hub >> /home/dev/tmux-boot-logs/wbtmux.txt 2>&1
