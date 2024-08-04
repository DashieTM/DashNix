{ config, pkgs, unstable, ... }:
let
  nextcloud_pw = (builtins.readFile /etc/nixos/nextcloud);
  forgejo_pw = (builtins.readFile /etc/nixos/dbpw/forgejo);
  matrix_pw = (builtins.readFile /etc/nixos/dbpw/matrix-synapse);
  mautrix_signal_pw = (builtins.readFile /etc/nixos/dbpw/mautrix_signal);
  mautrix_whatsapp_pw = (builtins.readFile /etc/nixos/dbpw/mautrix_whatsapp);
  mautrix_discord_pw = (builtins.readFile /etc/nixos/dbpw/mautrix_discord);

  fqdn = "matrix.${config.networking.domain}";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  networking.hostName = "dashie";
  networking.domain = "dashie.org";
  imports = [
    ./hardware-configuration.nix
    ./mautrix-whatsapp.nix
    ./mautrix-discord.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.hashedPassword = "!";
  users.users.dashie = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [
      unstable.neovim
      pkgs.fuse
      pkgs.ntfs3g
      pkgs.rsync
    ];
    openssh.authorizedKeys.keyFiles = [
      /home/dashie/server.pub
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  services.mautrix-whatsapp-dashie.enable = true;
  services.mautrix-discord-dashie.enable = true;
  services.matrix-synapse.enable = true;
  services.mautrix-signal.enable = true;
  services.matrix-synapse.settings = {
    server_name = "matrix.dashie.org";
    database.name = "psycopg2";
    database.args.user = "matrix-synapse";
    database.args.password = "${matrix_pw}";
    public_baseurl = "https://matrix.dashie.org";
    enable_registration = true;
    enable_registration_without_verification = true;
    suppress_key_server_warning = true;
    max_upload_size = "1G";
    listeners = [
      {
        port = 8008;
        bind_addresses = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [
          {
            names = [ "client" "federation" ];
            compress = true;
          }
        ];
      }
    ];
  };
  services.mautrix-whatsapp-dashie.settings = {
    appservice = {
      id = "whatsapp";
      database = {
        type = "postgres";
        uri = "postgresql:///mautrix_whatsapp?host=/run/postgresql&sslmode=disable&user=mautrix_whatsapp&password=${mautrix_whatsapp_pw}";
      };
    };
    bridge = {
      encryption = {
        allow = true;
        default = true;
        required = true;
      };
      displayname_template = "{{if .BusinessName}}{{.BusinessName}}{{else if .PushName}}{{.PushName}}{{else}}{{.JID}}{{end}}";
      permissions = {
        "@fabio.lenherr:matrix.org" = "admin";
        "@dashie:matrix.dashie.org" = "admin";
      };
    };
  };
  services.mautrix-signal.settings = {
    appservice = {
      id = "signal";
      database = {
        type = "postgres";
        uri = "postgresql:///mautrix_signal?host=/run/postgresql&sslmode=disable&user=mautrix_signal&password=${mautrix_signal_pw}";
      };
    };
    bridge = {
      encryption = {
        allow = true;
        default = true;
        required = true;
      };
      displayname_template = "{{or .ProfileName .PhoneNumber \"Unknown user\"}}";
      permissions = {
        "@fabio.lenherr:matrix.org" = "admin";
        "@dashie:matrix.dashie.org" = "admin";
      };
    };
  };
  services.mautrix-discord-dashie.settings = {
    appservice = {
      id = "discord";
      database = {
        type = "postgres";
        uri = "postgresql:///mautrix_discord?host=/run/postgresql&sslmode=disable&user=mautrix_discord&password=${mautrix_discord_pw}";
      };
    };
    bridge = {
      displayname_template = "{{or .GlobalName .Username}}{{if .Bot}} (bot){{end}}";
      permissions = {
        "@fabio.lenherr:matrix.org" = "admin";
        "@dashie:matrix.dashie.org" = "admin";
      };
    };
  };
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  services.nginx.virtualHosts."dashie.org" = {
    addSSL = true;
    enableACME = true;
    root = "/var/www/dashie.org/";
  };
  security.acme.certs."dashie.org".extraDomainNames = [ "cloud.dashie.org" "matrix.dashie.org" "git.dashie.org" "navi.dashie.org" ];
  services.nginx.virtualHosts."cloud.dashie.org" = {
    addSSL = true;
    enableACME = true;
    locations."/*".proxyPass = "http://127.0.0.1:12002";
  };
  services.nginx.virtualHosts."git.dashie.org" = {
    forceSSL = true;
    enableACME = true;
    locations."/".proxyPass = "http://127.0.0.1:3000";
  };
  services.nginx.virtualHosts."navi.dashie.org" = {
    addSSL = true;
    enableACME = true;
    locations."/".proxyPass = "http://127.0.0.1:4533";
  };

  services.nginx.virtualHosts."localhost" = {
    listen = [
      {
        addr = "0.0.0.0";
        port = 8448;
      }
    ];
    locations."/".proxyPass = "http://[::1]:8008";
  };

  services.nginx.virtualHosts."matrix.dashie.org" = {
    forceSSL = true;
    enableACME = true;
    locations."/".extraConfig = ''
      	return 404;
    '';
    locations."/_matrix" = {
      proxyPass = "http://[::1]:8008";
    };
    locations."/_synapse/client".proxyPass = "http://[::1]:8008";

    locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
    # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
    # Further reference can be found in the upstream docs at
    # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient
    locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
    extraConfig =
      "client_max_body_size 2G;"
    ;
  };

  services.nextcloud.enable = true;
  services.nextcloud.hostName = "cloud.dashie.org";
  services.nextcloud.https = true;
  services.nextcloud.config = {
    adminpassFile = "/etc/nixos/file2";
    dbuser = "nextcloud";
    dbhost = "/run/postgresql";
    dbname = "nextcloud";
    dbtype = "pgsql";
    dbpassFile = "/etc/nixos/nextcloud";
  };
  services.nextcloud.settings = {
    port = 12001;
    trusted_domains = [ "cloud.dashie.org" "192.168.1.23" ];
  };
  services.forgejo = {
    enable = true;
    database.passwordFile = /etc/nixos/dbpw/forgejo;
    settings = {
      server.DOMAIN = "git.dashie.org";
      server.SSH_PORT = 12008;
      server.SSH_LISTEN_PORT = 12008;
      server.START_SSH_SERVER = true;
      service.DISABLE_REGISTRATION = true;
    };
  };
  services.navidrome.enable = true;
  services.navidrome.settings = {
    MusicFolder = "/var/lib/nextcloud/data/DashieTM/files/Share/Music";
  };
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all   127.0.0.1/32   trust
      host  all       all   ::1/128   trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE DATABASE nextcloud;
            CREATE USER nextcloud WITH ENCRYPTED PASSWORD '${nextcloud_pw}';
            GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;

      CREATE DATABASE forgejo;
            CREATE USER forgejo WITH ENCRYPTED PASSWORD '${forgejo_pw}';
            GRANT ALL PRIVILEGES ON DATABASE forgejo TO forgejo;


      CREATE USER "matrix-synapse" WITH ENCRYPTED PASSWORD '${matrix_pw}'
      SELECT 'CREATE DATABASE "matrix-synapse" LOCALE "C" ENCODING UTF8 TEMPLATE template0 OWNER "matrix-synapse"'
      WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'matrix-synapse')\gexec

      CREATE USER mautrix_whatsapp WITH ENCRYPTED PASSWORD '${mautrix_whatsapp_pw}'
      SELECT 'CREATE DATABASE "mautrix_whatsapp" LOCALE "C" ENCODING UTF8 TEMPLATE template0 OWNER "mautrix_whatsapp"'
      WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'mautrix_whatsapp')\gexec

      CREATE USER mautrix_signal WITH ENCRYPTED PASSWORD '${mautrix_signal_pw}'
      SELECT 'CREATE DATABASE "mautrix_signal" LOCALE "C" ENCODING UTF8 TEMPLATE template0 OWNER "mautrix_signal"'
      WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'mautrix_signal')\gexec

      CREATE USER mautrix_discord WITH ENCRYPTED PASSWORD '${mautrix_discord_pw}'
      SELECT 'CREATE DATABASE "mautrix_discord" LOCALE "C" ENCODING UTF8 TEMPLATE template0 OWNER "mautrix_discord"'
      WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'mautrix_discord')\gexec
    '';
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "fabio.lenherr@gmail.com";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 4534 8448 12002 12004 12006 12008 ];
  };
  networking.firewall.allowPing = true;
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      max protocol = smb3
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.1. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/mnt/Shares/Public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 4 * * FRI      nobody    rsync -ato /var/lib/nextcloud/data /mnt/dump3/nextcloud"
      "0 4 * * FRI      nobody    pg_dympall > /mnt/dump3/sqdump.sql"
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;
  system.stateVersion = "24.05";
}
