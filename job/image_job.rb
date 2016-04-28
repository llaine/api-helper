class ImageJob
  include Sidekiq::Worker

  def perform
    # TODO, grabber les params et le file.
    size = "#{image_hash[:size][:width]}x#{image_hash[:size][:height]}+#{image_hash[:size][:x]}+#{image_hash[:size][:y]}"
    MiniMagick::Tool::Mogrify.new do |mogrify|
      mogrify.crop(size)
      mogrify << picture.file.url
    end
    picture.size = size
    picture.save
  end
end
