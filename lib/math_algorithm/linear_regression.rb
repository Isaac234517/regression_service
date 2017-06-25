class LinearRegression
  attr_reader :y
  attr_accessor :x, :thetas

  def initialize(x,y, thetas)
  	@x = x
  	@y = y
  	@thetas = thetas
  end

  def update_thetas(gradient,alpha)
  	@thetas = @thetas.map.with_index do |theta, index|
  		theta - alpha * gradient[index]
  	end
  end

  def cost_function
  	 h = hypothesis
  	 sqr_error = h.map.with_index do |element, index|
  	 	(element - @y[index]) * (element - @y[index])
  	 end
  	 summatation = sqr_error.inject(0) {|sum, element| sum+=element}
     summatation / ((2 * @x.length).to_f)
  end

  def gradient
  	 trans_x = MathUtil.transpose(@x)
     h = hypothesis
     difference = h.map.with_index do |element, index|
     	element - @y[index]
     end
     grad = trans_x.map.with_index do |element, index|
     	summatation = element.each_with_index.inject(0) do |sum,(sub_element, sub_index)|
     		if index !=0
         sum+= sub_element * difference[sub_index]
        else
         sum+=difference[sub_index]
        end
     	end
     	summatation/(@x.length).to_f
     end
     grad 
  end

  def hypothesis
    @x.map do |element|
  	   b = element.each_with_index.inject(0) do |sum,(sub_element,sub_index)|
  	   	  sum += sub_element * @thetas[sub_index]
  	   end
  	end
  end

  def self.divide_data(dataset)
  	x = []
  	y = []
  	dataset.each_with_index do |element,index|
  	  element.each_with_index do |sub_element, sub_index|
  	  	if(sub_index != element.length-1)
  	       x[index] ||=[]
  	  	   x[index] << sub_element
  	  	else
  	  	   y << sub_element
  	  	end
  	  end
  	  x[index].unshift(1)
  	end
  	[x,y]
  end
end