# encoding: utf-8

Model.new(:backup, ENV['BACKUP_NAME'].dup) do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = ENV['DATABASE_NAME'].dup
    db.username           = ENV['DATABASE_USERNAME'].dup
    db.password           = ENV['DATABASE_PASSWORD'].dup
    db.host               = ENV['DATABASE_HOST'].dup
    db.port               = ENV['DATABASE_PORT'].dup
  end

  ##
  # SFTP (Secure File Transfer Protocol) [Storage]
  #
  store_with SFTP do |server|
    server.username   = ENV['FTP_USERNAME'].dup
    server.password   = ENV['FTP_PASSWORD'].dup
    server.ip         = ENV['FTP_IP'].dup
    server.path       = ENV['FTP_PATH'].dup
    server.keep       = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Notifications
  #
  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true

    # The integration token
    slack.webhook_url = ENV['SLACK_URL'].dup
  end

end
