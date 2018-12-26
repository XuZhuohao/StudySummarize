# 删除git历史记录中的大文件
git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -5 | awk '{print$1}')"
```
8655f3cb40eb81a84c6bf0da1dc49be42a268580 spring boot/2.example/Resource01_ReadingListApplication.jpg
ad4bfd882d36b65a8897cff0f511eca555e5f689 spring boot/2.example/Resource03_ReadingListController.jpg
8012e48cf96dbc42d669469cca4dc44682d8fa23 spring boot/2.example/exclusions01.jpg
eea6aca2d4e0ef2015248d74396badba3aad6465 spring boot/2.example/pomFile.jpg
d3738e071e6094923f67fdbb081bf1e84d28a42b Frame/Spring/PureCodec_20180216.exe
```


$ git filter-branch --force --index-filter 'git rm -rf --cached --ignore-unmatch Frame/Spring/PureCodec_20180216.exe' --prune-empty --tag-name-filter cat -- --all
```
...
Rewrite c4247c16f6c55febd1e2261160b92afe83b73610 (162/162) (185 seconds passed, remaining 0 predicted)

Ref 'refs/heads/master' was rewritten
Ref 'refs/remotes/origin/master' was rewritten
WARNING: Ref 'refs/remotes/origin/master' is unchanged
```

$ rm -rf .git/refs/original/

$ git reflog expire --expire=now --all

$ git gc --prune=now

$ git push origin master --force