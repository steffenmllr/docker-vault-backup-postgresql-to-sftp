# encoding: utf-8
require 'vault'
require 'clockwork'

$token = Vault.logical.unwrap_token(ENV['VAULT_TOKEN'])

if $token.to_s == ''
    raise "Could not unwrap token"
end

Vault.token = $token

module Clockwork

  handler do |job|
    database_username = ENV.has_key?('VAULT_DATABASE_USERNAME') ? ENV['VAULT_DATABASE_USERNAME'] : 'secret/database/username'
    database_password = ENV.has_key?('VAULT_DATABASE_PASSWORD') ? ENV['VAULT_DATABASE_PASSWORD'] : 'secret/database/password'

    ftp_username = ENV.has_key?('VAULT_FTP_USERNAME') ? ENV['VAULT_FTP_USERNAME'] : 'secret/backup/username'
    ftp_pass = ENV.has_key?('VAULT_FTP_PASSWORD') ? ENV['VAULT_FTP_PASSWORD'] : 'secret/backup/password'

    backupEnv = {
        "FTP_USERNAME" => Vault.logical.read(ftp_username).data[:value],
        "FTP_PASS" => Vault.logical.read(ftp_pass).data[:value],
        "DATABASE_USERNAME" => Vault.logical.read(database_username).data[:value],
        "DATABASE_PASSWORD" => Vault.logical.read(database_password).data[:value],
    }

    system(backupEnv, "backup perform --trigger backup > /dev/null")
  end

  every(1.day, 'backup')
end

