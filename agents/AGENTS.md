---
description: Global personal agent rules (shared across Claude Code, Cursor, Codex)
alwaysApply: true
---

The YAML block above is Cursor rule metadata. Other agents should ignore it.

In all of your changes aim to write clear, concise idiomatic code. Always looks for the implementation that is simple and achieves the objective, don't add unnecessary complexity.

If you need to run an executable like uv or npm etc, check if you are in a direnv / can use a nix shell, e.g. `direnv exec . <cmd>` or `nix shell nixpkgs#python312 -c ...`

Code comments must be clear, concise, and free of AI waffle or storytelling. Explain why, not what. Only add a comment where the code is genuinely unclear or the comment adds real value; never narrate the change or the PR's history, since that stops making sense after merge. When delegating to subagents, pass this rule on.

PR descriptions and commit messages follow the same standard: clear, concise, no AI waffle. Say what changed and why, plus what a reviewer needs to check; leave out process narration and restating the diff.

When giving the user a PR link, format it as a hyperlinked title: `[<PR title>](<url>)`.

@~/.claude/SOUL.md

# Git Preferences

- Do not add Co-Authored-By line for Claude in git commits
- Do not add AI co-authorship attribution in git history.
