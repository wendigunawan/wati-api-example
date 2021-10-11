require 'faraday'
require 'twilio-ruby'

class WebhookController < ApplicationController

  def index

    Rails.logger.info "call webhook"
    Rails.logger.info params

    message_body = params[:Body]&.downcase

    message_body = message_body&.strip

    if ["hi", "hello", "helo", "hola"].include? message_body
      to = params[:From]
      account_name = params[:ProfileName]
      # message = "Halo #{account_name}, apa kabar hari ini?"
      message = "Halo #{account_name}"

      reply(to, message)
    end

    render json: { status: true }

  end

  private

  def reply(message_to, message_body)

    account_sid = Rails.application.config.twilio_account_id
    account_token = Rails.application.config.twilio_account_token
    account_phone_number = Rails.application.config.twilio_account_phone_number

    message_from = "whatsapp:#{account_phone_number}"

    Rails.logger.info "#{account_sid} | #{account_token} | #{account_phone_number} | #{message_from} | #{message_to} | #{message_body}"

    @client = Twilio::REST::Client.new(account_sid, account_token)



    response = @client.messages.create(
      from: message_from,
      body: message_body,
      to: message_to
    )

    Rails.logger.info response

  end

end
