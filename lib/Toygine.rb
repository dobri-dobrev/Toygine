#!/usr/bin/env ruby
require_relative 'parse/HTMLParser'
require_relative 'node/HTMLNode'



def runEngine(fileName)
	
	htmlparser = HTMLParser.new(fileName)
	htmlparser.read_file()
	htmlTree = htmlparser.parse()
	puts htmlTree	
end


if __FILE__ == $0
  puts "Initialized Engine \n+++++++++++++++++++++++++++++++++++++++++++"
  ARGV.each do |fileName|
  	runEngine(fileName)
  end
end