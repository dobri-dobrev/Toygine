#!/usr/bin/env ruby
require_relative 'parse/Parser'
require_relative 'node/Node'



def runEngine(fileName)
	parser = Parser.new(fileName)
	parser.read_file()
	parser.parse()	
end


if __FILE__ == $0
  puts "Launching Engine"
  ARGV.each do |fileName|
  	runEngine(fileName)
  end
end