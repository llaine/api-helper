require "cuba"
require "cuba/safe"
require 'oj'
require 'sidekiq'
require 'mini_magick'

MiniMagick.configure do |config|
  config.timeout = 5
end

require_relative "job/image_job"
require_relative "job/message_job"

Sidekiq.configure_client do |config|
  config.redis = { db:1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db:1 }
end

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  on get do
    on root do
      100.times do
        MessageJob.perform_async
        ImageJob.perform_async
      end
      res.write Oj.dump 'Hello World'
    end
  end
end
