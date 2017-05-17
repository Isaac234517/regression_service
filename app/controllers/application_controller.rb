require 'algorithm.rb'
require 'multi_json'
require 'json'
class ApplicationController < ActionController::API
  protected
  def send_respond(response)
  	render(json: MultiJson.dump(response))
  end
end
