## Pair Program With Me - Matcher

A sinatra app with github auth for Avdi

* see [ppwm](https://github.com/avdi/ppwm), [a ppwm scraper](https://github.com/martyhines/pair_with_me), and [rubypair](https://github.com/rubypair/rubypair)

## TODO

* a way to add codes
* persist codes, persist matched users
* link to user emails
* store data in the session
* fix deprecation warnings from github auth
* don't let codes be re-used by other users
* analytics?

## Setup

You'll want to have two [github applications](https://github.com/settings/applications/new), one for development, and one for production.

For each app, Make a note of the client ID and secret.

For production, enter your application URL `http://<domain>/` and
set the callback URL should be `http://<domain>/auth/github/callback`.

For development, set your application URL to `http://localhost/` and set your
callback URL to `http://localhost:9393/auth/github/callback`

### For development

Install the gems:

```bash
bundle
```

Then set up your the application config and database settings

```bash
./serve.sh setup`
```

Update the GITHUB keys in your `config/application.yml`


Finally start the web server using thin:

```bash
./serve.sh start
```

If you want to daemonize your dev server

```bash
./serve.sh start -d
./serve.sh stop
```

### Deploying to heroku (production)

  ```bash
  heroku addons:add heroku-postgresql:dev
  heroku config:set GITHUB_CLIENT_ID="<from GH>" GITHUB_CLIENT_SECRET="<from GH>"
  git push heroku master
  heroku run rake db:migrate
  ```

## License

Ask Avdi
