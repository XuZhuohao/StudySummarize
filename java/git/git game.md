# git game

## start game

>[root@localhost gitgame]# git clone https://github.com/hgarc014/git-game.git

```
Cloning into 'git-game'...
remote: Enumerating objects: 243, done.
remote: Total 243 (delta 0), reused 0 (delta 0), pack-reused 243
Receiving objects: 100% (243/243), 2.44 MiB | 419.00 KiB/s, done.
Resolving deltas: 100% (84/84), done.
```

## Level 1

**README.md**

```markdown
Welcome to the git-game!!
This is a terminal game designed to test your knowledge of git commands. Each level in the game is a task to perform on this repo. Once you perform that task, you will be given your next task. There are a total of ten levels, each one harder than last!

Let's get this journey started!!
Clone this repository by running:

$ git clone https://github.com/hgarc014/git-game.git
Don't know a lot about git??

Then you should check these files for assistance:

https://github.com/mikeizbicki/ucr-cs100/blob/2015winter/textbook/cheatsheets/git-cheatsheet.md

https://github.com/mikeizbicki/ucr-cs100/tree/2015winter/textbook/tools/git/advanced-git

Otherwise, you are free to continue...

You can win a badge for completing this game!

learn more about badges here: https://openbadgefactory.com/faq

You should always check the README.md file for your next clue!

Level 1

Your first task is to checkout the commit whose commit message is the answer to this question:

When a programmer is born, what is the first thing he/she learns to say?
```

**操作**

>[root@localhost git-game]# ls
```
LICENSE  README.md
```
>[root@localhost git-game]# vim README.md 
>[root@localhost git-game]# git log

```
commit d851edda3009332dd5d3f8f949a102f279dad809
Author: Henry Garcia <hgarc014@ucr.edu>
Date:   Wed Jun 10 21:03:04 2015 -0700

        updated README for badge notification

commit 7c8c3ccc2f4bb118a657f1f7a7ab4e163d1b7a30
Author: Henry Garcia <hgarc014@ucr.edu>
Date:   Wed Jun 10 20:57:08 2015 -0700

        added level1

commit 228389a54073ed1e6ec98e3bfa59039b416efd4d
Author: Henry Garcia <hgarc014@ucr.edu>
Date:   Wed Jun 10 20:56:34 2015 -0700

        added welcome screen

commit db99f2d9df4b2288d29a97d2d04a1703b4f3c107
Author: Henry Garcia <hgarc014@ucr.edu>
Date:   Wed Jun 10 20:55:35 2015 -0700

        updated README

commit 640273807f9bac8af03575f82b788663d4b99927
Author: Henry Garcia <hgarc014@ucr.edu>
Date:   Wed Jun 10 20:55:07 2015 -0700

        Hello World!

commit 8cafb7c87b129686da362b14c3f3c750c1fe4bf5
Author: Henry Garcia <hgarc014@ucr.edu>
```

>[root@localhost git-game]# git checkout 640273807f9bac8af03575f82b788663d4b99927

```
Note: checking out '640273807f9bac8af03575f82b788663d4b99927'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

 git checkout -b new_branch_name

HEAD is now at 6402738... Hello World!
```

## Level 2

**README.md**

```markdown
Hello World!

It looks like you have some knowledge about traversing commits!
Well, let's get this party started!
``Level 2``
We want to get to a branch whose name is the answer to this riddle:
I am a creature that is smaller than man, but many times more in number.
In code, my appearance can be subtle and no matter where I am found, I am unwanted.

What am I?
```

>[root@localhost git-game]# git branch -a

```
*(detached from 6402738) master remotes/origin/BillGates2014 remotes/origin/Daniel remotes/origin/HEAD -> origin/master remotes/origin/Henry remotes/origin/KenThompson2014 remotes/origin/Kevin remotes/origin/LinusTorvalds2014 remotes/origin/Mike remotes/origin/SteveJobs2014 remotes/origin/array remotes/origin/bug remotes/origin/code4life remotes/origin/keyboard remotes/origin/map remotes/origin/master remotes/origin/mouse remotes/origin/tree remotes/origin/trees remotes/origin/vector
```

**操作（导出分支）：**

>[root@localhost git-game]# git checkout bug



## Level 3

**README.md**

```markdown
git-game
========

Congratulations, it looks like you found the "bug."
When you work with other programmers on the same project, bugs are bound to appear.
One way to create bugs is by changing code that you did not write without understanding what the code is doing.

``Level 3``

Sometimes we like to blame others for introducing bugs in our code.
Think you can find out who introduced a bug into our file cool.cpp?
We think he had something to do with the development of git.
And from what we hear he also made a branch under his name.
Checkout to that branch after you find out who the culprit is.

If you are still confused, this link might [help](http://git-scm.com/docs/git-blame)
```

>[root@localhost git-game]# git log cool.cpp 

```
commit 3922a6d86ec4b0ea00c7b7414e96ffd3b2f65f45 Author: LinusTorvalds2014 <linustorvalds2014@gmail.com> Date:   Tue Dec 9 12:37:10 2014 -0800

       update

commit ce59bbfd5b04ece742e799c68bf94af2c46281d4 Author: Henry Garcia <hgarc014@ucr.edu> Date:   Mon Dec 8 18:22:35 2014 -0800

​     added cool.cpp and updated README
```

**操作**

>[root@localhost git-game]# git checkout LinusTorvalds2014

```
Branch LinusTorvalds2014 set up to track remote branch LinusTorvalds2014 from origin. Switched to a new branch 'LinusTorvalds2014'
```

## Level 4

**README.md**

```markdown
git-game
========

Looks like you found the branch of the evil Mastermind.
Things may start to get a little more challenging...

``Level 4``

The next clue you are looking for --
   is in a file you choose to ignore!

```

>[root@localhost git-game]# ls -a

```
.  ..  .git  .gitignore  LICENSE  README.md
```

>[root@localhost git-game]# vim .gitignore 

## Level 5

**.gitignore**

```shell
# welcome to the ignore file!!

#``Level 5``

# This file is hidden by default, 
# but did you know you have some branches that aren't shown to you,
# when you check the list of branches?
#
# For your next clue...
# Which abstract data type tends to implement sets and maps?? 
# The answer is the same answer to this riddle:
#
#   I am both mother and father.
#   I am seldom still
#   yet I never wander.
#   I never birth nor nurse.
#   
#   What am I?
#
# Afterwards... well, you
# know, checkout to the answer. 

*.rem
a.out

```

>[root@localhost git-game]# git checkout tree

```
Branch tree set up to track remote branch tree from origin. Switched to a new branch 'tree'
```

## Level 6

**README.md**

```markdown
git-game
========

``Level 6``

Welcome to the "tree" branch.
Looks like good ol' Linus modified the "nextclue_input.cpp" file.
Normally, when ran with the shell script "outputclue.sh", the "nextclue_input.cpp" file would give us the next hint.

Maybe, you should try running the shell script with the "nextclue_input.cpp" file and see what happens...

You can run the script by running the command "./outputclue.sh FILE" .
If you are on Windows, it's okey to use `git-bash` that is installed with [msysgit](https://msysgit.github.io/).

```

>[root@localhost git-game]# ls

```
LICENSE  nextclue_input.cpp  outputclue.sh  README.md
```

>[root@localhost git-game]# ./outputclue.sh nextclue_input.cpp 

```
Level 7:  Linus has been here... I love messing with these amateur programmers!! If you want some real fun, then you should try resolving a conflict between this branch (tree) and code4life. I introduced a little bug that you should fix in the conflict. >:) After you merge these 2 files you should run the shell script again!!

Good Luck!!!

Hint: https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/
```

## Level 7

**output**

```
Level 7: 
Linus has been here...
I love messing with these amateur programmers!!
If you want some real fun, then you should try resolving a conflict between this branch (tree) and code4life.
I introduced a little bug that you should fix in the conflict. >:)
After you merge these 2 files you should run the shell script again!!

Good Luck!!!

 Hint: https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/
```

> [root@localhost git-game]# git merge code4life

```
Auto-merging nextclue_input.cpp
CONFLICT (content): Merge conflict in nextclue_input.cpp
Automatic merge failed; fix conflicts and then commit the result.
```
>[root@localhost git-game]# vim nextclue_input.cpp 
(delete line:)
```
<<<<<<< HEAD

    cout << "This file was useless, so I made it better..." << endl;
    while(1);
=======
```
>[root@localhost git-game]# ./outputclue.sh nextclue_input.cpp 

```
Well, congratulations!! You fixed my conflict!!
If you would like to continue, then you should checkout to the mouse branch!!
```
>[root@localhost git-game]# git reset --hard origin/tree
>[root@localhost git-game]# git checkout mouse

```
Branch mouse set up to track remote branch mouse from origin.
Switched to a new branch 'mouse'
```




## Level 8

**README.md**

``` markdown

git-game
========

``Level 8``

Looks like you resolved your conflict and found our branch, congrats!!

Hmm...it seems this branch has a file that was seen before in another branch.
Do you "remember" what it is?
I think this file has something to do with the next clue, but it seems to be very ugly looking.
Maybe if we compare the "diff"erences between this file and the file from before we'll know where to go next...
```
>[root@localhost git-game]# git diff bug..mouse remember

```
diff --git a/remember b/remember
index 584a931..76bd37c 100644
--- a/remember
+++ b/remember
@@ -2312,7 +2312,7 @@ C7EpVk1Cth5p2tKx0w58i ytUWbvyeysGWv jS4QWZkzlAN2m3EqLffpZiy1XM izQzulpiV Q5eNfJ7
 mrLDUvQK6M 2bREkk3RREZe6Ulawm3SU KHtoKj6jzKwhFYPzhcx1O4Culugp 0UzKqH9CjHM8akQ156fOYAeUUFp McAAI BHuGYzuoqoTSY 7Rby9YLfIMMcysFELGcL1rLD QAo0CaRo22ZfTaf2k iu9KM9ukJ67 EtoBFF9N2Dup5prFQ1 B51i0K
 5NKuMyGGyQum5oQkvP8Am08 OeNWMuTPJIpaBkK LupcmcIO4axxMfp8KnAo m7PFvaY9M5fAn9lfo7Bkm4PBvJJ01 ii2LvkHC8gJ EsHtRTZToBKe pA7ij1m1 bkgGGuQjorQhc0l3bkb7XUoJjII 5ul hxlFoWzySnS M nUlxc5wg2VNIz7lSuuC
 57EyTqwnFMX 3CmavTItFa9yjtSIjZ i1VTU06u9rj HShUtnwlqL7ZUZP0i8o7hq U0cS Cr9 sTRitmSvJ7pSDPdd5Emzh xKPGY7mUWTn972NHq HjtdwgQN45QNSZr fyYf 1kBsF5xzcRoyv5K08jlAfoc oG Byz6CAD G4rpwi7HbWlxa0tge m
-Sn In a branch named: Henry YtrydjKsYqebDoI3h bTINUeV6 pTVY8jnK2re HRwwNy25Ps6 u0YChCo5Jtw N3xkH3G nx aGo6yQTW RVZMsf3xk tBL0sG9GAR HQbyGYdqs i6dx1fyIPGJVciz8Z1NzdrvGE CKgkFauXqfKJmas cDLerW
+Sn The next clue is: YtrydjKsYqebDoI3h bTINUeV6 pTVY8jnK2re HRwwNy25Ps6 u0YChCo5Jtw N3xkH3G nx aGo6yQTW RVZMsf3xk tBL0sG9GAR HQbyGYdqs i6dx1fyIPGJVciz8Z1NzdrvGE CKgkFauXqfKJmas cDLerWvBTRzUi
 n9ec28c7rYYGTF W933ju5 pyH8PXHnKhlwLU0C2akSaPrlpprD spXXhVp6X A6dTg1fBfNBwSvp1sw91Dav67x8f8b Q DAUTWahNriDlArXunXMJ3b489 lcgvI2SViBLrCulZCwsi4kog 4rDVp 90SWto6WkU4Qj gANCojbKr1omMS3hm6p1csqH
 lDSkBLh Sy7L w4X8QJuiL yJ 9KjSn2C12NV 5E7H9S4M7LrV lgxJn1Q8xcnyprQ34g2tC7 Doc36AAsmi58xKa0 kRQntjBdrPfD0QLOj1m ChzWh7JLGBRU Xs446EYE71sHMjtbSsOW4LeVK hzcX391c0Kpyj5bL7sSI5NmE ZrBux2YhJypFB07
 lMrAVrH6 ZzHYozHGN f fE5ficRh2 pMQ6rpXtT49gijgjsO5eykZ9A o 30Tz1Agt5XgV 6odhdhHyYpV8U ZV qc3xnKKPYmjkeJwNGlAtXj f65vcbrsDI7od0E 50EVbGO7iT8Nk2Tilx52wRddM9HeA U8pEHg21Y5CfYjtI5Mnz GZ4lwoqno2Y
```
```
In a branch named: Henry
```

> [root@localhost git-game]# git checkout -b Henry origin/Henry
```
Branch Henry set up to track remote branch Henry from origin.
Switched to a new branch 'Henry'
```

## Level 9
## Level 10

**README.md**
```markdown
git-game
========

``Level 10``

Welcome!! It looks like you made it to my Branch!!!
Generally you want to refrain from making tags the same name as branches, unless you have a good reason.
The tag is more like the stable release.
While the branch is more like the in progress feature, which will be added soon.

You're almost done!! Excited?? Hope you are! You have one more thing to do!

Now its time to update the master branch, updating is really useful when you fork a repository and your forked repo starts to get behind on commits. The repository to update from is: https://github.com/drami025/git-game.git

Don't cheat!!

Here is a [link](https://help.github.com/articles/configuring-a-remote-for-a-fork/) that explains how to fork a remote repository.

```


