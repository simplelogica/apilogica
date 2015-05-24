module Services
  class Slack < Base
    # Get util slack params from http request
    def parse_params params
      @resource_name, @query = params[:text].split(' ', 2) if params[:text]
      @options = {
        channel: params[:channel_name] ? "##{params[:channel_name]}" : nil,
        user_name: params[:user_name],
        token: params[:token]
      }
    end

    def request options
      data = {
        channel: @options[:channel] || '#apilogica',
        username: 'Apilogica',
        text: options[:text] || "Sent by #{@options[:user_name]} with '#{query}'",
        icon_emoji: ':crystal_ball:',
        attachments: [
          {
            title: options[:title] || nil,
            title_link: options[:title_link] || nil,
            text: options[:text] || nil,
            pretext: options[:pretext] || nil,
            image_url: options[:image] || nil,
            mrkdwn_in: ['pretext']
          }
        ]
      }
      # Slack callback needs a payload param with the json data
      http_request @api_service.callback_url, payload: data.to_json
    end
  end
end
