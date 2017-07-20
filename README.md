
# docker-hubot

## ビルド

```shell
docker build -t docker-hubot:latest .
```

## 実行

```shell
docker run -d -e HUBOT_LOG_LEVEL=debug HUBOT_SLACK_TOKEN=<hubot_slack_token> -p 9999:9999 docker-hubot
```

## 初回のみログインして作業

コンテナにログイン
```shell
docker exec -it <container_id> bash
```

(コンテナ内) ssh public keyをgithubのdeploy keysに追加
deploy keysであればread-onlyでリポジトリにアクセスできるようになります。
```shell
cat .ssh/id_rsa.pub # これをgithubのdeploy keysに追加
```

(コンテナ内) hubotスクリプトをインポートする
```shell
git clone <repository url>
rm -rf /hubot/scripts
ln -s hubot-scripts/scripts /hubot/
```

## scriptを更新

```slack
@bot-name update
```
