## Pair Program With Me - Matcher

A sinatra app with github auth for Avdi

* see [ppwm](https://github.com/avdi/ppwm), [a ppwm scraper](https://github.com/martyhines/pair_with_me), and [rubypair](https://github.com/rubypair/rubypair)

## TODO

* below the 'code' input field, add an email field pre-populated from github, if available 
* a way to add codes
* persist codes, persist matched users
* link to user emails
* store data in the session
* fix deprecation warnings from github auth
* don't let codes be re-used by other users
* analytics?

## Setup

First, you need to [create a github application](https://github.com/settings/applications/new). Make a note of the client ID and secret. Your callback URL should be `http://<domain>/auth/github/callback`.

### For development

Install the gems:

```bash
bundle
```

Then set the application settings as environment variables:

```bash
export GITHUB_CLIENT_ID="<from GH>"
export GITHUB_CLIENT_SECRET="<from GH>"
```

Finally start the web server using thin:

```bash
bundle exec thin start  # start the server on 0.0.0.0:3000
```

### Deploying to heroku

  ```bash
  heroku addons:add heroku-postgresql:dev
  heroku config:set GITHUB_CLIENT_ID="<from GH>" GITHUB_CLIENT_SECRET="<from GH>"
  ```

## License

Ask Avdi
