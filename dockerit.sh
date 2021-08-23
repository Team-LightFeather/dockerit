#/usr/bin/sh
set -x
docker rm -f $1
if [ $1 = "node" ]; then
    docker run -td -p 3000:3000 -p 8000:8000 --name $1 -v /`pwd`:/$HOME/working -w=$HOME/working -u `id -u`:`id -g` -e npm_config_cache=/tmp/.npm -e HOME=$HOME -m 2g --entrypoint sh $1
elif [ $1 = "gradle" ]; then
    docker run -td -p 8080:8080 --name $1 -v /`pwd`:/$HOME/working -w=$HOME/working -u `id -u`:`id -g` -e HOME=$HOME -m 2g --entrypoint sh $1
else
    docker run -td --name $1 -v /`pwd`:/$HOME/working -w=$HOME/working -u `id -u`:`id -g` -e HOME=$HOME -m 2g --entrypoint sh $1
fi
docker cp $HOME/.ssh/ $1:/$HOME/.ssh
docker cp $HOME/.aws/ $1:/$HOME/.aws
docker cp $HOME/.gitconfig $1:/$HOME/.gitconfig
docker cp $HOME/.vimrc $1:/$HOME/.vimrc
docker cp $HOME/bin/docker_bash_profile $1:/$HOME/.bash_profile
docker exec $1 chmod 700 $HOME/.ssh/id_rsa_lightfeather
docker cp $1://etc/passwd /tmp/passwd
grep -vP "\w+:\w:`id -u`" /tmp/passwd > /tmp/passwd2
echo "`whoami`:x:`id -u`:`id -g`:,,,:/home/`whoami`:/bin/bash" >> /tmp/passwd2
cat /tmp/passwd2
docker cp /tmp/passwd2 $1://etc/passwd
docker exec -u root $1 chown `whoami` $HOME
if [ $1 = "terraform" ]; then
    docker exec -u `id -u`:`id -g` -it $1 sh
else
    docker exec -u `id -u`:`id -g` -it $1 bash
fi
