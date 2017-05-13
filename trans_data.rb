
new_file = File.open('test3.txt','w+')
File.open('test2.txt', "r+") do |file|
    file.each_line do |line|
    	line = "[ #{line.gsub!("\n",'')} ],"
    	new_file.puts(line)
    end
    file.close
end
new_file.close