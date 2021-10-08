class WebhookController < ApplicationController

  def index

    Rails.logger.info "call webhook"

    render json: ["hello"]

  end

end
