require 'faraday'
require 'twilio-ruby'

class WebhookController < ApplicationController

  def index

    Rails.logger.info "call webhook"
    Rails.logger.info params

    message_body = params[:Body]&.downcase

    message_body = message_body&.strip

    if ["hi", "hello", "helo", "hola"].include? message_body
      from = params[:From]
      to = params[:To]
      account_name = params[:ProfileName]
      message = "Halo #{account_name}, apa kabar hari ini?"
      reply(from, to, message)
    end

    render json: { status: true }

  end

  private

  def reply(from, to, message)

    account_sid = Rails.application.config.twilio_account_id
    account_token = Rails.application.config.twilio_account_token

    # today = DateTime.now.strftime("%Y-%m-%d")
    #
    # faraday = Faraday.new(
    #   url: 'https://api.twilio.com',
    #   headers: {'Content-Type' => 'application/json'}
    # )
    #
    # response = faraday.post("/#{today}/Accounts/#{account_sid}/Messages.json") do |req|
    #   req.params['From'] = from
    #   req.params['To'] = to
    #   req.params['Body'] = message
    # end

    Rails.logger.info "#{account_sid} | #{account_token} | #{from} | #{to} | #{message}"

    @client = Twilio::REST::Client.new(account_sid, account_token)

    response = @client.messages.create(
      from: from,
      to: to,
      body: message
    )

    Rails.logger.info response

  end

end
