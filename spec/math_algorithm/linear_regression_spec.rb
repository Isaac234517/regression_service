require 'spec_helper'
describe LinearRegression do 
  before(:all) do
  	data_str = File.open(File.join(File.dirname(__FILE__),"../data/linear_regression_test2.json"))
    data = MultiJson.load(data_str, :symbolize_keys => true)
    @dataset = data[:dataset]
    @thetas = data[:thetas]
  end

  context 'check linear regression answer' do
  	it 'should defined data correctly' do 
  	  x_y = LinearRegression.divide_data(@dataset)
  	  expect(x_y[0].length).to eq(@dataset.length)
  	  expect(x_y[1].length).to eq(@dataset.length)
  	end

  	it 'should calculate expect cost'do
  		x_y = LinearRegression.divide_data(@dataset)
  		thetas = @dataset[0].map{|ele| 0}
  		logistic = LinearRegression.new(x_y[0], x_y[1], thetas)
  		expect(logistic.cost_function).to eq(32.072733877455654)
    end

    it 'should calcuate correct gradient at thets [0,0,0]' do
    	x_y = LinearRegression.divide_data(@dataset)
    	thetas = @dataset[0].map{|ele| 0}
    	logistic = LinearRegression.new(x_y[0], x_y[1], thetas)
    	expect(logistic.gradient_descent).to eq([-5.83913505154639,-65.32884974555672])
    end
  end
end