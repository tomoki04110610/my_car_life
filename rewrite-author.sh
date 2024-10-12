#!/bin/sh

OLD_EMAIL="ec2-user@ip-172-31-28-249.ap-northeast-1.compute.internal"
CORRECT_NAME="tomoki04110610"
CORRECT_EMAIL="161846373+tomoki04110610@users.noreply.github.com"

git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
