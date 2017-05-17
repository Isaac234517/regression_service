class MathUtil
   def self.transpose(arr)
      trans_arr = []
      arr.each_with_index do |element, index|
      	element.each_with_index do |sub_element, sub_index|
      		trans_arr[sub_index] ||=[]
      		trans_arr[sub_index] << sub_element
      	end
      end
      trans_arr
    end
end