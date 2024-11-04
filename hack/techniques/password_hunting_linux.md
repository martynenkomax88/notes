---
id: password_hunting_linux
aliases: []
tags: []
---


Password Hunting – Filenames and File Contents
When it comes to password hunting, one of the first things we should do is perform a high-level search to look for files that contain “password” in the filename. In addition to filenames, we should also be looking for the string “password” inside files.

Hunting for Interesting Filenames
We should start by looking for filenames that contain the word “password” in them before looking for the string “password” inside files on the filesystem. Additionally, we should also be looking for filenames that contain any other interesting strings that we can think of (config, php, etc.)

There are a few commands we can use to perform this type of search.

First, we can use the following find command, which is nice because the pipe into grep will make all string matches red:

find / -exec ls -lad $PWD/* "{}" 2>/dev/null \; | grep -i -I "passw\|pwd"
The above search will be quite long winded and take some time to finish since it is checking the entire filesystem for any filenames that contain the strings “passw” or “pwd”. The nice thing about this search is “passw” covers passw, passwd, and password; and then “pwd”, is another common interpretation of the word password.

Another command that we can use to comb the entire filesystem for files that contain a certain string in their name is the locate command.

locate 'passw'
locate 'pwd'
locate '*.php'
What’s awesome about the locate command is that it works REALLY FAST, which allows us to play with the keywords and search for a variety of different filenames / filetypes in a short amount of time.

Both ways of searching for files with a specific string in their name will produce a lot of results, but if we take our time to review the output, we may find some JUICY files that have passwords inside.

Hunting for Interesting Strings Inside Files
There is a nice utilization of the grep command that we can use to search for files that contain the string “passw” and “pwd” across the entire filesystem; however, it does produce a RIDICULOUS amount of results.

grep --color=auto -rnw '/' -iIe "PASSW\|PASSWD\|PASSWORD\|PWD" --color=always 2>/dev/null
This search shows the string in red as well as the full file path in purple and the line number where the string was found inside the file. The only issue with this search, is that the amount of output is just absurd. It will take quite some time to parse through, so it’s probably a better idea to perform more granular and targeted searches.

To get more granular, we can navigate to a folder of interest and then we can run the same command as above. This time, we will drop the ‘/’ potion so that it recursively greps files from the current folder only.

For example, we can navigate to common folders where we normally find interesting files, such as /var/www, /tmp, /opt, /home, etc. and then execute the following command:

grep --color=auto -rnw -iIe "PASSW\|PASSWD\|PASSWORD\|PWD" --color=always 2>/dev/nul  

![[Pasted image 20241104122040.png]]
