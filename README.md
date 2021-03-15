![Corgidon](https://i.imgur.com/NhZc40l.png)
========

[![Build Status](https://img.shields.io/circleci/project/github/msdos621/corgidon.svg)][circleci]

[circleci]: https://circleci.com/gh/msdos621/corgidon

Corgidon is a fork of [Mastodon](https://github.com/tootsuite/mastodon/blob/master/README.md).  It serves as the codebase for my instance [banana.dog](https://banana.dog).  It also serves as a testing ground for changes I am trying to get upstream into mastodon and/or [florencesoc](https://github.com/florence-social).

# Notable Difference from Mastodon

- Configurable Biography length
- Configurable Toot length
- Option to override the join url instead of directing people to joinmastodon.org
- Reports instance info using the nodeinfo spec just like pleroma and others
- Media takes the full width of the timeline in which it is contained
- Larger Emoji
- Default pink theme replaces default mastodon theme (see themes section)
- Public moderation log availible to logged in users (see below)
![public moderation log](https://shiba.banana.dog/media_attachments/files/003/723/324/original/f3f160f3dc70ae2a.png)

# Themes

CorgiDon comes bundled with some themes from other instances as well as some unique themes.  Here they are

### Jigglypuff (default theme)

![jigglypuff](https://shiba.banana.dog/media_attachments/files/002/665/857/original/2f08a05dda848192.png)

### Cybrespace

![cybrespace](https://shiba.banana.dog/media_attachments/files/002/665/858/original/e514f218df0e765f.png)

### Cybrespace Light

![cybrespace light](https://shiba.banana.dog/media_attachments/files/002/665/859/original/16f4064377a62e86.png)

### Cybrespace Windows 95

![cybrespace 95](https://shiba.banana.dog/media_attachments/files/002/665/856/original/729e4612dae7fade.png)

### meemu.org

![meemu-org](https://shiba.banana.dog/media_attachments/files/004/332/066/original/c0a5835d2c028b52.png)

### GeoDude

![geodude](https://shiba.banana.dog/media_attachments/files/002/665/843/original/287d96895ea60b33.png)

### Sleeping Town

![royal tennebaumbs](https://shiba.banana.dog/media_attachments/files/002/665/848/original/d0cab2a711de20a9.png)

### Royal Tennebaumbs

![royal tennebaumbs](https://shiba.banana.dog/media_attachments/files/002/665/845/original/82f3fab0f150606a.png)

### Witches Town

![witches town](https://shiba.banana.dog/media_attachments/files/002/665/844/original/bfffb692af586977.png)

# Things I tried and later removed

- Recaptcha option for login (removed since upstream mastodon introduced ability to review sign ups)
- Collopsable toots (replaced my implimentation with the "Read more>> feature from upstream")
- Option to show direct messages in your home timeline

# Docker Compose Install

A rough guide to how to setup an instance with docker-compose

## Prereqs

- A machine running some version of linux with docker and docker-compose installed
- A domain name (or a subdomain) for the Mastodon server, e.g. example.com
- An e-mail delivery service or other SMTP server to use for mail delivery
- Nginx
- SSL certs / lets-encrypt for your chosen domain

- create a directory for installation, make a note of the full path for later use

```
mkdir corgidon
cd corgidon
pwd corgidon
```

- pull down .env and update *DB_PASS* , *SMTP* settings, *LOCAL_DOMAIN* and any other things you want to change and save the file.

```
curl https://raw.githubusercontent.com/msdos621/corgidon/main/.env.production.sample  > .env.production
```

- pull down the example docker-compose file

```
curl https://raw.githubusercontent.com/msdos621/corgidon/main/docker-compose.yml  > docker-compose.yml
```

- pull the latest version of the docker containers

```
docker-compose pull
```

- generate SECRET_KEY_BASE and OTP_SECRET by running the following command twice.  Set them in the .env.production file

```
docker-compose run --rm web bundle exec rake secret
```

- generate VAPID_PRIVATE_KEY and VAPID_PUBLIC_KEY by running the following command twice.  Set them in the .env.production file

```
docker-compose run --rm web bundle exec rake mastodon:webpush:generate_vapid_key
```

- run db setup and migrate

```
docker-compose run --rm web rails db:setup
docker-compose run --rm web rails db:migrate
```

- rebuild assets

```
docker-compose run --rm web rails assets:precompile
```

- start the corgidon server

```
docker-compose up -d
```

- ensure the media upload directory has proper permission

```
chown -R 991:991 public
```

- setup nginx by pulling down the config file then editing it (replace example.com and /home/mastodon/ with your domain and your installation directory

```
cd /etc/nginx/sites-availible 
curl https://raw.githubusercontent.com/msdos621/corgidon/main/dist/nginx.conf  > /etc/nginx/sites-available/example.com
ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
nginx -t
service nginx reload
```

- Navigate to your instance and sign up for an account
- Give that new account admin privlidges

```
cd ~/corgidon
docker-compose run --rm web bin/tootctl accounts modify alice --role your_username
```
