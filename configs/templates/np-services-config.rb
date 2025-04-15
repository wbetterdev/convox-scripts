# rubocop:disable all
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
    'apache-waybetter-selfsigned' => '.waybetter.com',
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

  NP_SERVICE_DICT = {
    :hub        => { name: 'wb-hub',                 gitname: 'wb-hub',                  type: 'node',        port: 3000 },
    :graphql    => { name: 'wb-graphql-service',     gitname: 'wb-graphql',              type: 'node',        port: 3003 },
    :admin_auth => { name: 'wb-admin-auth-service',  gitname: 'wb-admin-auth-service',   type: 'node',        port: 8020 },
    :admin_web  => { name: 'wb-admin-web',           gitname: 'wb-admin-web',            type: 'node',        port: 8010 },
    :falkor     => { name: 'falkor-game-service',    gitname: 'falkor-game-service',     type: 'ruby',        port: 3004 },
    :quitbet    => { name: 'quitbet-game-service',   gitname: 'quitbet-game-service',    type: 'ruby',        port: 3005 },
    :notify     => { name: 'wb-notify-service',      gitname: 'wb-notify-service',       type: 'ruby',        port: 3007 },
    :runbet     => { name: 'runbet-game-service',    gitname: 'runbet-game-service',     type: 'ruby',        port: 3010 },
    :metric     => { name: 'wb-metric-service',      gitname: 'wb-metric-service',       type: 'ruby',        port: 3002 },
    :auth       => { name: 'wb-auth-service',        gitname: 'wb-auth-service',         type: 'node',        port: 8000 },
    :user       => { name: 'wb-user-service',        gitname: 'wb-user-service',         type: 'node',        port: 4000 },
    :member     => { name: 'wb-membership-service',  gitname: 'wb-membership-service',   type: 'ruby',        port: 3009 },
    :billing    => { name: 'wb-billing-service',     gitname: 'wb-billing-service',      type: 'ruby',        port: 3006 },
    :social     => { name: 'wb-social-service',      gitname: 'wb-social-service',       type: 'ruby',        port: 3005 },
    :asset      => { name: 'wb-asset-service',       gitname: 'wb-asset-service',        type: 'ruby',        port: 3011 },
  }

  # set this to false if you don't have local convox started
  LOCAL_CONVOX_ENABLED = true

  LOCAL_KRAKEN_SERVICES = []
  LOCAL_CONVOX_SERVICES = []
  REMOTE_SERVICES = [
    :hub, :member, :admin_auth, :auth, :admin_web, :graphql,
    :quitbet, :runbet, :notify,
    :user, :billing, :social, :metric, :falkor
  ]

  # when true, this will use hub-staging.waybetter.com instead of hub-local.waybetterder.com
  USE_STAGING_DOMAIN_LOCALLY = false

  NP_SERVICES = {
    local_kraken:         LOCAL_KRAKEN_SERVICES.map {|s| NP_SERVICE_DICT.fetch(s)},
    local_convox:         LOCAL_CONVOX_SERVICES.map {|s| NP_SERVICE_DICT.fetch(s)},
    remote_convox_office: REMOTE_SERVICES.map {|s| NP_SERVICE_DICT.fetch(s)},
    local_apache: [
      { name: 'stepbet-game-service',   path: '/var/www/stepbet',             type: 'php'},
      { name: 'dev-stepbet',            path: '/var/www/stepbet',             type: 'php'},
      { name: 'prod-stepbet',           path: '/var/www/stepbet',             type: 'php'},
      { name: 'dietbet-game-service',   path: '/var/www/dietbet',             type: 'php'},
      { name: 'dev-dietbet',            path: '/var/www/dietbet',             type: 'php'},
      { name: 'prod-dietbet',           path: '/var/www/dietbet',             type: 'php'},
      { name: 'dietbet-imageserver',    path: '/var/www/dietbet-imageserver', type: 'php'},
      { name: 'phpmyadmin',             path: '/var/www/phpmyadmin',          type: 'php'},
    ]
  }

end
# rubocop:enable all
