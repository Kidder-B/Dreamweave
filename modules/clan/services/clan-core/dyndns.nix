{
  clan.inventory.instances = {
    dyndns = {
      roles.default.machines."home-server" = { };

      roles.default.settings = {
        period = 5; # update every 5 minutes

        settings = {
          "homevpn" = {
            provider = "your-ddns-provider"; # e.g. "duckdns", "namecheap", "porkbun"
            domain = "vpn1.homevpn.example.com";

            # This tells clan which secret key to use from your secret manager (see step 2)
            secret_field_name = "token"; # or "password", "api_key", "secret_api_key", depends on provider

            # Extra provider-specific options that get passed verbatim to ddns-updater config.json
            extraSettings = {
              # provider-specific fields here, e.g. for duckdns:
              # token = "<your-duckdns-token>";

              # for porkbun:
              # api_key = "...";
              # secret_api_key = "...";

              # For duckdns you might only need the token in your secret manager.
            };
          };
        };
      };
    };
  };

}
