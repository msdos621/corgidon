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
### GeoDude
![geodude](https://shiba.banana.dog/media_attachments/files/002/665/843/original/287d96895ea60b33.png)
### Sleeping Town
![royal tennebaumbs](https://shiba.banana.dog/media_attachments/files/002/665/848/original/d0cab2a711de20a9.png)
### Royal Tennebaumbs
![royal tennebaumbs](https://shiba.banana.dog/media_attachments/files/002/665/845/original/82f3fab0f150606a.png)
### Witches Town
![witches town](https://shiba.banana.dog/media_attachments/files/002/665/844/original/bfffb692af586977.png)

# Things I tried and later removed
- Recaptcha option for loing (removed since upstream mastodon introduced ability to review sign ups)
- Collopsable toots (replaced my implimentation with the "Read more>> feature from upstream")
- Option to show direct messages in your home timeline
