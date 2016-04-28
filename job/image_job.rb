class ImageJob
  include Sidekiq::Worker

  def perform
    puts 'Hello World from image'
  end
end
