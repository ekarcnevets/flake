{ config, ... }:
let
  # A Nix path would be copied into the store and the installed file would be read-only.
  agentsMd = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/src/github.com/ekarcnevets/flake/agents/AGENTS.md";
in
{
  home.file.".claude/CLAUDE.md".source = agentsMd;
  home.file.".cursor/rules/global.mdc".source = agentsMd;
  home.file.".codex/AGENTS.md".source = agentsMd;
}
