require 'spec_helper'
describe LogisticRegression do
  before(:all) do 
    data_str = File.open(File.join(File.dirname(__FILE__),"../data/logistic_regression_test.json"))
    data = MultiJson.load(data_str, :symbolize_keys => true)
  end

  context 'check logistic regression answer' do
  	it 'should calculate expect cost'do 
    end
  end
end
