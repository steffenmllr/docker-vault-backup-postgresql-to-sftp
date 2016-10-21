FROM ruby:2.3.1
MAINTAINER Steffen Müller <steffen@mllrsohn.com>

RUN apt-get -y -q update && apt-get -y -q install postgresql-9.4
RUN gem install backup -v 4.3.0 --no-rdoc --no-ri
RUN gem install vault clockwork --no-rdoc --no-ri
RUN backup generate:model --trigger backup --databases='postgresql' --storages='ftp'

COPY config.rb /root/Backup/models/backup.rb
COPY config.rb /root/Backup/backup.rb

CMD ["clockwork", "/root/Backup/backup.rb"]
