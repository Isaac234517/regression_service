require 'spec_helper'
describe MathUtil do
  it 'should get the right answer when you transpose array' do
  	array = [
  				[1,2,3],
  				[4,5,6],
  				[7,8,9]
  			]

  	result = [
  				[1,4,7],
  				[2,5,8],
  				[3,6,9]
  			]

  	 expect(MathUtil.transpose(array)).to eq(result)
  end

  it 'should calculate mean' do
  	array = [1,2,3,6,8]
  	expect(MathUtil.mean(array)).to eq(4)
  end

  it 'should calculate variance' do
  	array = [1,2,3,6,8]
  	expect(MathUtil.variance(array)).to eq(6.8)
  end

  it 'should calculate standard deviation' do
  	array = [1,2,3,6,8]
  	expect(MathUtil.standard_deviation(array)).to eq(2.6076809620810595)
  end

  it 'should do standardization' do 
    array = [1,2,3,6,8]
    expect(MathUtil.standardization(array)).to eq([-1.1504474832710556, -0.7669649888473704, -0.3834824944236852, 0.7669649888473704, 1.5339299776947408])
  end
end