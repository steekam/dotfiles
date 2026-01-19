# Create GitLab Merge Request

Create a merge request for the current branch using glab CLI.

## Steps:
1. Check current branch and ensure it's not main/master/develop
2. Check for uncommitted changes and prompt if any exist
3. Push the branch to remote if needed
4. Look for MR template:
   - First check `.gitlab/merge_request_templates/` in the repo
   - If not found, fetch from project settings: `glab api "projects/<url-encoded-path>" | jq -r .merge_requests_template`
5. Generate MR title from branch name or recent commits
6. Create MR with `glab mr create` using the template
7. Return the MR URL

Use `--draft` if the branch name contains `wip` or `draft`.
