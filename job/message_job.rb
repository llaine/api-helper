class MessageJob
  include Sidekiq::Worker
  # Turning off the retry
  sidekiq_options :retry => 0


  def perform(user, notification)
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {
      :from    => 'iamrob@bot.nicetomateyou.com',
      :to      => user['email'],
      :subject => 'Hi there',
      :text    => generate_html(user, notification)
    }

    mg_client.send_message 'api.preprod.nicetomateyou.com', message_params
  end

  private

  def generate_html(user, notification)
    "<!DOCTYPE html>
      <html>
        <head>
          <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
        </head>
        <body>
          <h1>Hi #{user['email']}</h1>
          <p>
            You have a new notification in nicetomateyou
            #{notification['subject']}
          </p>
        </body>
      </html>"
  end

end
