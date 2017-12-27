#!/bin/bash

repo_path=/ss-accounts





cd $repo_path
cur_time=$(date '+%Y-%m-%d %H:%M:00')
git add *
git commit -a -m "updated at ${cur_time}"
git push
