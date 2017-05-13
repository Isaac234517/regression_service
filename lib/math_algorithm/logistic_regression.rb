class LogisticRegression
  def initialize(x,y,theta)
  	@x = x
  	@y = y 
  	@theta = theta
  end

  def z_func
  	ans = []
  	@x.each do |ele|
  		row_ans = ele.each_with_index.inject(0) do |initial_value, (sub_ele,sub_index)|
  			initial_value += (sub_ele * @theta[sub_index])
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

  def sigmod(z)
    1/(1+ Math.exp(0-z))
  end

  def hy_part(z)
  	ans = []
  	z.each_with_index do |element, index|
  		ans << ((0-@y[index]) * Math.log(sigmod(element))- (1-@y[index]) * Math.log(1-sigmod(element)))
  	end
  	ans
  end

  def sigma(ans)
  	result = ans.inject(0) do |sum,value|
  		sum+=value
  	end
    result
  end

  def grad_descent
    z = z_func
    result = []
    trans_x = tranpose(@x)
    p 'trans_x', trans_x
    p 'x', @x
    trans_x.each do |ele|
      z.each.with_index do |sub_ele,index|
        tmp_result = sigma(sub_ele)-@y[index]
      trans_x.
    end
  end

  def tranpose(arr)
    tmp_arr = []
    arr.each.with_index do |ele|
      ele.each.with_index do |sub_ele, sub_index|
        tmp_arr[sub_index]||=[]
        tmp_arr[sub_index] << ele[sub_index]
      end
    end
    tmp_arr
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