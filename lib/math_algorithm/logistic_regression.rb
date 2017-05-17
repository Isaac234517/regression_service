class LogisticRegression
  attr_reader :x,:y
  attr_accessor :thetas
  def initialize(x,y,thetas)
  	@x = x
  	@y = y 
  	@thetas = thetas
  end

  def update_thetas(gradient,learning_rate)
    @thetas = @thetas.map.with_index {|theta,index| theta-(learning_rate *gradient[index])}
  end

  def z_func
  	ans = []
  	@x.each do |ele|
  		row_ans = ele.each_with_index.inject(0) do |initial_value, (sub_ele,sub_index)|
  			initial_value += (sub_ele * @thetas[sub_index])
  		end
  		ans << row_ans
  	end
  	ans
  end


  def cost_function
  	z = z_func
  	sigma_part = hy_part(z)
  	cost = 1/(@x.length.to_f) * sigma(sigma_part)
  end

  def sigmoid(z)
    1/(1+ Math.exp(0-z))
  end

  def hy_part(z)
  	ans = []
  	z.each_with_index do |element, index|
      #p "element#{element}"
      #p (1-@y[index]) * Math.log(1-sigmoid(element))
      #part1 = (0-@y[index]) * Math.log(sigmoid(element))
      #part2 = (1-@y[index]) * Math.log(1-sigmoid(element))
      #part2 = 0 if part2.nan?
      #ans << (part1-part2)
  		ans << ((0-@y[index]) * Math.log(sigmoid(element))- (1-@y[index]) * Math.log(1-sigmoid(element)))
  	end
  	ans
  end

  def sigma(ans)
  	result = ans.inject(0) do |sum,value|
  		sum+=value
  	end
    result
  end

  def gradient_descent
    z = z_func
    result = []
    trans_x = MathUtil.transpose(@x)
    arr_part = z.map.with_index{|element,index| sigmoid(element)-@y[index]}
    gradient = trans_x.map do |trans_element|
      product = trans_element.each_with_index.inject(0){|sum, (sub_element,index)| sum+=arr_part[index] * sub_element}
      product /= @x.length
    end
    gradient
  end

  def self.divide_data(data)
  	x = []
  	y = []
  	data.each.with_index do |ele, index|
      tmp_x = []
      tmp_y = 0
  	  ele.each_with_index do |sub_ele, sub_index|
  	  	if sub_index == ele.length - 1
  	  	  tmp_y = sub_ele 
  	  	else
  	  	  tmp_x << sub_ele
  	  	end
  	  end
  	  x << tmp_x.unshift(1)
  	  y << tmp_y
  	end
  	[x,y]
  end
end