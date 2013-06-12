ENV['RACK_ENV'] ||= 'development'
# per https://devcenter.heroku.com/articles/ruby#logging
$stdout.sync = true
require "rubygems"
require "bundler/setup"
require './lib/ppwm-matcher/app.rb'
use Rack::Static,
  :urls => [],
  :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'image/x-icon',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/favicon.ico', File::RDONLY)
  ]
}

run PpwmMatcher::App
