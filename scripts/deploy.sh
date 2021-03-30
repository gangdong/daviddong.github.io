#!/bin/sh
set -e

# setup ssh-agent and provide the GitHub deploy key
openssl aes-256-cbc -K $encrypted_70fbe34e406c_key -iv $encrypted_70fbe34e406c_iv -in blog_id_rsa.enc -out blog_id_rsa -d
# 对解密后的私钥添加权限
chmod 600 blog_id_rsa

# 启动 ssh-agent
eval "$(ssh-agent -s)"

ssh-add blog_id_rsa

# 删除解密后的私钥
rm blog_id_rsa

git config --global user.name 'Travis'  
git config --global user.email 'travis@travis-ci.com' 

# commit the assets in storybook-static/ to the gh-pages branch and push to GitHub using SSH
cp ./_site/* ../site
git checkout test_travisci
rm -rf *
cp ../site/* ./
git add --all .
git commit -m "Travis CI Auto Builder"
git push -u origin master
