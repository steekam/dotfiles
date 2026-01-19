# List GitLab Issues

List and filter GitLab issues from the central product backlog.

## Central Repo
All issues are managed in: `engineering/product-backlog` (https://gitlab.patrium.health/engineering/product-backlog)

## Arguments
$ARGUMENTS - optional filters (e.g., "assigned to me", "label:bug", issue number)

## Steps:
1. Parse arguments for filters
2. Use appropriate glab command with `-R engineering/product-backlog`:
   - `glab issue list -R engineering/product-backlog` for listing
   - `glab issue view <number> -R engineering/product-backlog` for specific issue
3. Display results in a readable format
