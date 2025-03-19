sudo hexo generate
sudo hexo clean

echo "commit message? "
read commitmsg

git add .
git commit -m "$commitmsg"
git push -u origin main

