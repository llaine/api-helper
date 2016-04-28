require "cuba"
require "cuba/safe"
require 'oj'
require 'sidekiq'

require_relative "job/image_job"
require_relative "job/message_job"

redis = { url: 'redis://127.0.0.1:6379' }
Sidekiq.configure_client { |config| config.redis = redis }
Sidekiq.configure_server { |config| config.redis = redis }

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe

Cuba.define do
  on get do
    on root do
      100.times do
        MessageJob.perform_async
        ImageJob.perform_async
      end
      res.write 'Hello World'
    end
  end
end
