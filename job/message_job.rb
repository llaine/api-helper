class MessageJob
  include Sidekiq::Worker

  def perform
    puts 'Hello World from email'
  end
end
