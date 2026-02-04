{ ... }: {
  # SSH allowed signers for signature verification
  home.file.".ssh/allowed_signers".text = ''
    ekarcnevets@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJOkkyB57orOxVPLOZ8YhMDTmvqj5b2fi0Cy5DRlwuEZ
    steven.crake@nscale.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoxhIV4lNUvgM/1ORLBrc+tmr7esOJqRGZWUShgRMfj
  '';

  # SSH configuration for 1Password
  home.file.".ssh/config".text = ''
    Include /Users/steven/.config/colima/ssh_config
    Include /Users/steven/.colima/ssh_config

    # Default host – personal GitHub
    Host github.com
      User git
      IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
      IdentityFile ~/.ssh/github_ekarcnevets_moon_1pw.pub
      IdentitiesOnly yes

    # Nscale GitHub – use different key
    Host github.com-nscale
      HostName github.com
      User git
      IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
      IdentityFile ~/.ssh/github_nscale_moon_1pw.pub
      IdentitiesOnly yes

    # Fallback
    Host *
      IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  '';

  # 1Password SSH agent configuration
  home.file.".config/1Password/ssh/agent.toml".text = ''
    # This is the 1Password SSH agent config file, which allows you to customize the
    # behavior of the SSH agent running on this machine.
    #
    # You can use it to:
    # * Enable keys from other vaults than the Private vault
    # * Control the order in which keys are offered to SSH servers
    #
    # You can test the result by running:
    #
    #  SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ssh-add -l
    #
    # More examples can be found here:
    #  https://developer.1password.com/docs/ssh/agent/config

    # Personal GitHub key - only for github.com
    [[ssh-keys]]
    item = "github_ekarcnevets_moon_1pw"
    vault = "Private"

    # Nscale GitHub key - only for github.com-nscale
    [[ssh-keys]]
    item = "github_nscale_moon_1pw"
    vault = "Employee"

    # Load all other keys from Private vault (for Azure DevOps, etc.)
    [[ssh-keys]]
    vault = "Private"
  '';
}
