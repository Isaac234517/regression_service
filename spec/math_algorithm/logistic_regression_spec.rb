require 'spec_helper'
describe LogisticRegression do
  before(:all) do 
    data_str = File.open(File.join(File.dirname(__FILE__),"../data/logistic_regression_test.json"))
    data = MultiJson.load(data_str, :symbolize_keys => true)
    @dataset = data[:dataset]
    @thetas = data[:thetas]
  end

  context 'check logistic regression answer' do
  	it 'should defined data correctly' do 
  	  x_y = LogisticRegression.divide_data(@dataset)
  	  expect(x_y[0].length).to eq(@dataset.length)
  	  expect(x_y[1].length).to eq(@dataset.length)
  	end

  	it 'should calculate expect cost'do
  		x_y = LogisticRegression.divide_data(@dataset)
  		thetas = @dataset[0].map{|ele| 0}
  		logistic = LogisticRegression.new(x_y[0], x_y[1], thetas)
  		expect(logistic.cost_function).to eq(0.693147180559946)
    end

    it 'should calcuate correct gradient at thets [0,0,0]' do
    	x_y = LogisticRegression.divide_data(@dataset)
    	thetas = @dataset[0].map{|ele| 0}
    	logistic = LogisticRegression.new(x_y[0], x_y[1], thetas)
    	expect(logistic.gradient_descent).to eq([-0.1,-12.00921658929115,-11.262842205513591])
    end
  end
end
