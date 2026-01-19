# Check GitLab Pipeline Status

Check the CI/CD pipeline status for the current branch.

## Steps:
1. Get current pipeline status with `glab ci status`
2. If there are failures, get job logs with `glab ci trace`
3. Summarize:
   - Overall pipeline status
   - Failed jobs and their error messages
   - Suggestions for fixing failures
