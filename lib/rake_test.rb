#!/usr/bin/env ruby

puts "winning"
fileObj = File.new(ARGV[0], "r")
fileObj.each_line do |line|
	puts line
end