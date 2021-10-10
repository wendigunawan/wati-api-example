class WebhookController < ApplicationController

  def index

    Rails.logger.info "call webhook"
    Rails.logger.info params

    render json: ["hello"]

  end

end
