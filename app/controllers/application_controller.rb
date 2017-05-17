require 'algorithm.rb'
class ApplicationController < ActionController::API
  protected
  def send_respond(response)
  	render(json: MultiJson.dump(response))
  end
end
