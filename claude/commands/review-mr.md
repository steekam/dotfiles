# Review GitLab Merge Request

Review a merge request using glab CLI.

## Arguments
$ARGUMENTS - MR number or URL (optional, uses current branch's MR if not provided)

## Steps:
1. Get MR details with `glab mr view`
2. Get the diff with `glab mr diff`
3. Check pipeline status with `glab ci status`
4. Review the changes and provide feedback on:
   - Code quality and style consistency
   - Potential bugs or issues
   - Test coverage
   - Security concerns
   - Performance implications
5. Summarize findings with actionable suggestions
