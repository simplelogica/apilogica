module Services
  class Slack < Base
    def request options
      data = {
        channel: options[:channel] || "#apilogica",
        username: "Apilogica",
        text: options[:text]|| "",
        icon_emoji: ":crystal_ball:",
        attachments: [
          { image_url: options[:image]}
        ]
      }
      # Slack callback needs a payload param with the json data
      http_request @api_service.callback_url, payload: data.to_json
    end
  end
end
