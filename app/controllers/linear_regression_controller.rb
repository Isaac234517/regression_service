class LinearRegressionController < ApplicationController
  before_action :parse_params

  def find_best_thetas
    if(@standardization == true)
      transpose_feature = MathUtil.transpose(@handler.x)
      after_standardization = transpose_feature.map.with_index do |element, index|
        MathUtil.standardization(element) if index !=0
      end
      transpose_feature = [transpose_feature[0]] + after_standardization.compact
      @handler.x = MathUtil.transpose(transpose_feature)
    end

  	cost = @handler.cost_function
  	Rails.logger.info "Initial thetas is #{@handler.thetas.inspect}"
  	num = 0
  	begin 
  	  gradient = @handler.gradient
  	  @handler.update_thetas(gradient,@learning_rate)
  	  Rails.logger.info "After upate thetas at iteration #{num+1} #{@handler.thetas.inspect}"
  	  new_cost = @handler.cost_function
  	  break if new_cost - cost >=0.01
  	  cost = new_cost
  	  num+=1
  	end while num < @iterations

  	Rails.logger.info "Best thetas is #{@handler.thetas.inspect} after running interation #{num}"
  	send_respond({'best_thetas' => @handler.thetas})
  end

  def calculate_cost
  	Rails.logger.info "Calculate cost at theats #{@handler.thetas.inspect}"
  	cost = @handler.cost_function
    Rails.logger.info "Cost is #{cost}"
    send_respond({'cost' => cost})
  end

  def cost_and_gradient
  	Rails.logger.info "Calculate cost at theats #{@handler.thetas.inspect}"
  	cost = @handler.cost_function
  	Rails.logger.info "Cost is #{cost}"
  	Rails.logger.info "Calcuate its gradient at thetas#{@handler.thetas.inspect}"
  	gradient = @handler.gradient
  	@handler.update_thetas(gradient,0.01)
  	Rails.logger.info @handler.thetas
  	Rails.logger.info "gradient is #{gradient.inspect}"
  	send_respond({'cost' => cost, 'grad' => gradient})
  end

  def parse_params
    data_string = params['data'] || request.body.read
    data = MultiJson.load(data_string, :symbolize_keys => true)
    raise 'error' unless data.key?(:dataset)
    x_y = LinearRegression.divide_data(data[:dataset])
    unless data.key?(:thetas)
      thetas = x_y[0][0].map{|ele| 0}
    else
      thetas = data[:thetas]
    end
    @handler = LinearRegression.new(x_y[0], x_y[1], thetas)
    @iterations =  data[:iterations] || 1
    @standardization = data[:standardization] || false 
    @learning_rate = data[:learning_rate] || 0.1
  end

end
