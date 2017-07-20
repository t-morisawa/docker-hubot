FROM ubuntu:16.04

RUN apt update
RUN apt -yqq install redis-server nodejs npm && \
    apt -yqq install emacs vim git openssh-client && \
    apt -yqq clean && \
    apt -yqq autoclean && \
    apt -yqq autoremove && \
    rm -rf /var/lib/apt/* && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/* && \
    rm -rf /tmp/*

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

RUN	useradd -d /hubot -m -s /bin/bash -U hubot

USER	hubot
WORKDIR /hubot

RUN yo hubot --owner="Toma Morisawa" --name="test-bot" --description="hello bot world" --defaults

# Add here all the hubot plugins
RUN npm install hubot-slack --save && npm install
RUN npm install forever --save && npm install
# RUN npm install pm2 && npm install
# RUN npm install -g forever

COPY external-scripts.json /hubot/
RUN rm -rf /hubot/hubot-scripts.json

COPY clone-scripts.sh /hubot/
RUN ssh-keygen -q -t rsa -N '' -f /hubot/.ssh/id_rsa

CMD node_modules/forever/bin/forever -c coffee node_modules/.bin/hubot -a slack
