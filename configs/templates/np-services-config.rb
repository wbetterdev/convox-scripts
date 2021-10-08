
class NpServices < OpBase

  # local/convox or dev
  LOCAL_CONVOX_RACK = 'local/convox'

  CONVOX_RACKS = {
    "local" => LOCAL_CONVOX_RACK,
    "staging" => "waybetter/stagingv3",
  }.freeze

  CERTIFICATES = {
    'apache-local-selfsigned' => '.convox.local',
    'apache-office-selfsigned' => '.convox.office',
    'apache-waybetterdev-selfsigned' => '.waybetterdev.com',
    'apache-ninja-selfsigned' => '.waybetter.ninja',
    'apache-dietbet-selfsigned' => 'local.dietbet.com', 
  }

  SERVER_IPS = {
    localhost:                '127.0.0.1',
    convox_office_external:   '188.244.27.49',
    convox_office_internal:   '192.168.100.28',
  }

  CONFIG_TYPE_COVOX_OFFICE = 'config-convox-office'
  CONFIG_TYPE_DEV_PC = 'config-dev-pc'


  CONFING_TYPE = CONFIG_TYPE_DEV_PC
  NP_SERVICES = {
    local_kraken: [
      { name: 'wb-graphql-service',     gitname: 'wb-graphql',              type: 'node',        port: 3003 },
      { name: 'wb-admin-web',           gitname: 'wb-admin-web',            type: 'node',        port: 8010 },
      { name: 'wb-hub',                 gitname: 'wb-hub',                  type: 'node',        port: 3000 },
      { name: 'wb-user-service',        gitname: 'wb-user-service',         type: 'node',        port: 4000 },
      { name: 'wb-admin-auth-service',  gitname: 'wb-admin-auth-service',   type: 'node',        port: 8020 },
      { name: 'wb-auth-service',        gitname: 'wb-auth-service',         type: 'node',        port: 8000 },
    ],
    local_convox: [
      { name: 'wb-social-service',      gitname: 'wb-social-service',       type: 'ruby',       port: 3005 },
    ],
    remote_convox_office: [
      { name: 'wb-notify-service',      gitname: 'wb-notify-service',       type: 'ruby' },
      { name: 'dietbet-game-service',   gitname: 'dietbet-game-service',    type: 'ruby' },
      { name: 'falkor-game-service',    gitname: 'falkor-game-service',     type: 'ruby' },
      { name: 'quitbet-game-service',   gitname: 'quitbet-game-service',    type: 'ruby' },
      { name: 'runbet-game-service',    gitname: 'runbet-game-service',     type: 'ruby' },
      { name: 'stepbet-game-service',   gitname: 'stepbet-game-service',    type: 'ruby' },
      { name: 'wb-billing-service',     gitname: 'wb-billing-service',      type: 'ruby' },
      { name: 'wb-membership-service',  gitname: 'wb-membership-service',   type: 'ruby' },
      { name: 'wb-metric-service',      gitname: 'wb-metric-service',       type: 'ruby' },
    ],
    local_apache: [
      { name: 'stepbet',                path: '/var/www/stepbet',           type: 'php'},
      { name: 'dev-stepbet',            path: '/var/www/stepbet',           type: 'php'},
      { name: 'prod-stepbet',           path: '/var/www/stepbet',           type: 'php'},
      { name: 'dietbet',                path: '/var/www/dietbet',           type: 'php'},
      { name: 'dev-dietbet',            path: '/var/www/dietbet',           type: 'php'},
      { name: 'prod-dietbet',           path: '/var/www/dietbet',           type: 'php'},
      { name: 'phpmyadmin',             path: '/var/www/phpmyadmin',        type: 'php'},
    ]
  }

  # CONFING_TYPE = CONFIG_TYPE_COVOX_OFFICE
  # NP_SERVICES = {
  #   local_kraken: [
  #     { name: 'wb-graphql-service',     gitname: 'wb-graphql',           type: 'node',        port: 3003 },
  #     { name: 'wb-admin-web',           gitname: 'wb-admin-web',         type: 'node',        port: 8010 },
  #   ],
  #   local_convox: [
  #     { name: 'wb-admin-auth-service',  gitname: 'wb-admin-auth-service',  type: 'node' },
  #     { name: 'wb-notify-service',      gitname: 'wb-notify-service',      type: 'ruby' },
  #     { name: 'dietbet-game-service',   gitname: 'dietbet-game-service',   type: 'ruby' },
  #     { name: 'falkor-game-service',    gitname: 'falkor-game-service',    type: 'ruby' },
  #     { name: 'quitbet-game-service',   gitname: 'quitbet-game-service',   type: 'ruby' },
  #     { name: 'runbet-game-service',    gitname: 'runbet-game-service',    type: 'ruby' },
  #     { name: 'stepbet-game-service',   gitname: 'stepbet-game-service',   type: 'ruby' },
  #     { name: 'wb-auth-service',        gitname: 'wb-auth-service',        type: 'node' },
  #     { name: 'wb-billing-service',     gitname: 'wb-billing-service',     type: 'ruby' },
  #     { name: 'wb-membership-service',  gitname: 'wb-membership-service',  type: 'ruby' },
  #     { name: 'wb-metric-service',      gitname: 'wb-metric-service',      type: 'ruby' },
  #     { name: 'wb-hub',                 gitname: 'wb-hub',                 type: 'node' },
  #     { name: 'wb-social-service',      gitname: 'wb-social-service',      type: 'ruby',       port: 3005 },
  #     { name: 'wb-user-service',        gitname: 'wb-user-service',        type: 'node',       port: 4000 },
  #   ],
  #   remote_convox_office: [

  #   ],
  #   local_apache: [
  #     { name: 'stepbet',                path: '/var/www/stepbet',           type: 'php'},
  #     { name: 'stepbet-prod',           path: '/var/www/stepbet-prod',      type: 'php'},
  #     { name: 'phpmyadmin',             path: '/var/www/phpmyadmin',        type: 'php'},
  #   ]
  # }

end