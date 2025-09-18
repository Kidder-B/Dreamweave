{
flake.modules.lib.mkWifiCreds =
  wifiGeneratorName: {
  ${wifiGeneratorName} = {
    prompts.ssid.description = "SSID name";
    prompts.ssid.type = "line";
    prompts.ssid.persist = true;

    prompts.psk.description = "PSK for the SSID";
    prompts.psk.type = "hidden";
    prompts.psk.persist = true;

    # single output file containing the PSK (secret)
    files."psk".secret = true;
    files."psk".name = "psk";

    script = ''
      mkdir -p $out
      # write the PSK; SSID is available at $prompts/ssid if you need it
      cat $prompts/psk > $out/psk
      chmod 0400 $out/psk
    '';
  };
};
}
