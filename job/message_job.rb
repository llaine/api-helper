class MessageJob
  include Sidekiq::Worker

  def perform
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => 'iamrob@bot.nicetomateyou.com',
                      :to      => user.email,
                      :subject => 'Hi there',
                      :text    => "
      <!DOCTYPE html>
      <html>
        <head>
          <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
        </head>
        <body>
          <h1>Hi #{user.email}</h1>
          <p>
            You have a new notification in nicetomateyou
            #{notif.subject}
          </p>
        </body>
      </html>
    "}
    mg_client.send_message 'api.preprod.nicetomateyou.com', message_params
  end
end
