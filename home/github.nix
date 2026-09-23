{ osConfig, ... }:
# GitHub SSH auth + commit signing via the 1Password agent.
# Per-host key resolved from that machine's 1Password account:
#   - moon        -> personal account, "Private" vault
#   - wagestation -> Nscale account,   "Employee" vault
let
  hostname = osConfig.networking.hostName;
  hosts = {
    moon = {
      pub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOkkyB57orOxVPLOZ8YhMDTmvqj5b2fi0Cy5DRlwuEZ";
      vault = "Private";
    };
    wagestation = {
      pub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMnrMvfiIxq5kNycNC9ckEtQz05uHMlElNE1W6OnfaU";
      vault = "Employee";
    };
  };
  h = hosts.${hostname};
  keyName = "github_ekarcnevets_${hostname}_1pw";
in
{
  programs.git.settings.user.signingkey = h.pub;

  home.file.".ssh/${keyName}.pub".text = h.pub;

  home.file.".ssh/config".text = ''
    Include /Users/steven/.config/colima/ssh_config
    Include /Users/steven/.colima/ssh_config

    Host github.com
      User git
      IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
      IdentityFile ~/.ssh/${keyName}.pub
      IdentitiesOnly yes

    # Fallback
    Host *
      IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  '';

  home.file.".config/1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    item = "${keyName}"
    vault = "${h.vault}"
  '';

  # Trust every host's signing key so commits verify locally on any machine.
  home.file.".ssh/allowed_signers".text = ''
    ekarcnevets@gmail.com ${hosts.moon.pub}
    ekarcnevets@gmail.com ${hosts.wagestation.pub}
  '';
}
