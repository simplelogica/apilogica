module Services
  class Slack < Base
    # Get util slack params from http request
    def parse_params params
      {
        channel: params[:channel_name] ? "#{params[:channel_name]}" : nil,
        user_name: params[:user_name],
        token: params[:token]
      }
    end

    def request options
      data = {
        channel: @options[:channel] || '#apilogica',
        username: 'Apilogica',
        text: options[:text] || "Sent by #{@options[:user_name]}",
        icon_emoji: ':crystal_ball:',
        attachments: [
          { image_url: options[:image] }
        ]
      }
      # Slack callback needs a payload param with the json data
      http_request @api_service.callback_url, payload: data.to_json
    end
  end
end
