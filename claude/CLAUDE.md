# Communication Style
- Be extremely concise. Sacrifice grammar for the sake of concision.

# Code Style Guidelines

When writing or modifying code, follow these principles to avoid common AI-generated patterns:

## Avoid Unnecessary Comments
- Only add comments where the logic is genuinely non-obvious
- Match the commenting style of the existing file
- Don't add redundant comments explaining self-evident code

## Avoid Over-Defensive Code
- Don't add extra try/catch blocks unless the code path genuinely needs error handling
- Don't add defensive null/undefined checks for values that are guaranteed by the type system or calling context
- Trust validated/trusted internal codepaths

## Maintain Type Safety
- Never cast to `any` to work around type issues - fix the underlying type problem instead
- Preserve existing type patterns in the codebase

## Match Existing Style
- Follow the conventions already established in each file
- Don't "improve" formatting, naming, or structure unless explicitly asked
- Keep changes minimal and focused on the task at hand

## Dotfiles
- Main dotfiles are in `~/.dotfiles` (shared across machines)
- Machine-specific customizations are in `~/.dotfiles-custom`
- When modifying shell config or dotfiles, determine if the change is universal or machine-specific

## JSON Processing
- Use `jq` for JSON processing in bash, not python one-liners

## Environment Variables in Commands
- When running commands with env var prefixes, use `env` instead of inline assignment so the permission system matches correctly
  - Bad: `PATRIUM_VARIANT=preview npm run build`
  - Good: `env PATRIUM_VARIANT=preview npm run build`

## Local Tooling
- The project's `node_modules/.bin` is part of PATH, so tools like `expo`, `vite`, `tsc`, `eslint`, etc. can be executed directly without `npx`
- Projects use `mise` as the primary runtime and task manager
  - Check `.mise.toml` or `mise.toml` for project configuration
  - Use `mise run <task>` for project tasks defined in mise config
  - Use `mise tasks` to list available tasks
  - Runtime versions are managed via mise - use `mise install` if tools are missing

## GitLab (gitlab.patrium.health)
- Use the `glab` CLI tool for all GitLab operations (MRs, issues, pipelines, CI)
- Common commands: `glab mr create`, `glab mr list`, `glab mr view`, `glab issue list`, `glab ci status`, `glab pipeline list`
- When creating MRs, check for templates in this order:
  1. First check `.gitlab/merge_request_templates/` in the repo
  2. If not found, fetch from project settings via API: `glab api "projects/<url-encoded-path>" | jq -r .merge_requests_template`
- Use the template content for the MR description. Avoid `--fill` as it skips templates.
- **Important:** Use `--description` for MR body content, NOT `--body` (which doesn't exist in glab)
- When merging with squash, ensure the squash commit message includes a summary of all changes made in the MR
- If `glab mr create --recover` fails, ignore recovery and retry the full command

### GitLab API Patterns
Use raw API when `glab` CLI lacks options:

**Overriding MR approvals:**
```bash
# List approval rules
glab api "projects/<url-encoded-path>/merge_requests/<iid>/approval_rules"
# Override a rule to 0 approvals
glab api --method PUT ".../approval_rules/<rule_id>" -f "approvals_required=0"
```

**Merging with specific options:**
```bash
# glab mr merge doesn't expose all flags - use API for fine control
glab api --method PUT "projects/<path>/merge_requests/<iid>/merge" \
  -f "squash=false" \
  -f "should_remove_source_branch=false"
```

**Waiting for MR pipeline:**
```bash
# Check MR pipeline status
glab api "projects/<path>/merge_requests/<iid>" | jq '{status: .pipeline.status, mergeable: .detailed_merge_status}'
# Poll until status is "success" before merging
```
