class OpServers < OpBase
  HOSTNAMES = {
    convox_office_external: '188.244.27.49',
    convox_office: '192.168.100.28'
  }
  SERVERS = {
    convox_office_external: {
      user: 'dev',
      key: '~/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames: [:convox_office_external],
      port: 3022
    },
    convox_office: {
      user: 'dev',
      key: '~/Work/docs/secrets/keys/ubuntu-work-ssh.pem',
      hostnames: [:convox_office]
    }
  }
end
