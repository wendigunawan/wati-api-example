require 'faraday'

class MessageController < ApplicationController

  BASE_URL = 'https://app-server.wati.io'
  TOKEN = '<your token>'

  # get all messages by phone number
  def index
    phone_number = params[:phone_number]

    response = Faraday.get "#{BASE_URL}/api/v1/getMessages/#{phone_number}", nil, {'Authorization': "Bearer "}

    @data = {
      phone_number: phone_number
    }

    if response.status === 200
      response_body = JSON.parse(response.body)
      @data[:messages] = response_body['messages']['items']
    end

    render json: @data
  end

end
