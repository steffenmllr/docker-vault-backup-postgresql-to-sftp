# docker-backup-vault-postgresql-to-sftp

    A docker image with the ruby backup gem that is used to backup a postgresql container,
    gets the credentials from a hashicorp vault, upload it to sftp and notify slack.
    It backups day

##### Usage

```
docker run -d --restart=always \
-e VAULT_ADDR=https://127.0.0.1:8200
-e VAULT_TOKEN=WRAPPED_VAULT_TOKEN
-e VAULT_DATABASE_USERNAME='/path/to/database/username' \
-e VAULT_DATABASE_PASSWORD='/path/to/database/password' \
-e VAULT_FTP_USERNAME='/path/to/ftp/username' \
-e VAULT_FTP_PASSWORD='/path/to/ftp/password' \
-e DATABASE_NAME='DATABASE_NAME' \
-e FTP_IP=FTP_IP \
-e FTP_PATH=Path \
-e BACKUP_NAME='My Awesome Backup'
-e SLACK_URL='https://hooks.slack.com/services/XXXXXXXXXX' \
steffenmllr/docker-backup-vault-postgresql-to-sftp
```

##### Build
https://hub.docker.com/r/steffenmllr/docker-backup-vault-postgresql-to-sftp
