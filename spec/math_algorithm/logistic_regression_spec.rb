describe LogisticRegression do
  before(:all) do 
    data_str = File.open("../data/logistic_regression_test.json")
    data = MultiJson.load(data_str, :symbolize_keys => true)
  end
end
