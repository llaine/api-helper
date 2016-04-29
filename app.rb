require "cuba"
require "cuba/safe"
require 'oj'
require 'sidekiq'
require 'mini_magick'
require 'mailgun'

require_relative "job/image_job"
require_relative "job/message_job"


MiniMagick.configure do |config|
  config.timeout = 5
end

Sidekiq.configure_client do |config|
  config.redis = { db:1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db:1 }
end

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  on post do
    on "image", param('image') do |attrs|

    end

    on "mail", param('user'), param('notification') do |user, notification|
      MessageJob.perform_async(user, notification)
      res.write 200
    end
  end
end
