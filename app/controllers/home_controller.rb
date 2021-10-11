class HomeController < ApplicationController

  def index

    @data = {
      name: 'wati-api-example',
      version: '0.0.1-beta',
      _timestamp: DateTime.now.utc
    }

    render json: @data

  end

end
