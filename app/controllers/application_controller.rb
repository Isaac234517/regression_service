require 'algorithm.rb'
require 'json'
class ApplicationController < ActionController::API
  protected
  def send_respond(response)
  	render(json: response.to_json)
  end
end
