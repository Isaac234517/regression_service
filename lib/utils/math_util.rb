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

    def self.mean(arr)
      summatation = arr.inject(0){|sum, element| 
         sum+=element
      }
      summatation/arr.length
    end

    def self.variance(arr)
      m = self.mean(arr)
      sqr_summatation = arr.inject(0){|sum,element| sum+=(element - m) * (element-m)}
      (sqr_summatation / arr.length.to_f)
    end

    def self.standard_deviation(arr)
       Math.sqrt(self.variance(arr))
    end

    def self.standardization(arr)
      m = self.mean(arr)
      deviation = self.standard_deviation(arr)
      arr.map do |element|
        (element - m)/ deviation
      end
    end
end