#!/bin/sh

cd /home/maks/notes/
git pull origin
git add .
git commit -m "x"
git push -f
