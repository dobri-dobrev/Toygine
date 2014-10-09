#!/usr/bin/env ruby
require_relative 'parse/HTMLParser'
require_relative 'node/HTMLNode'



def runEngine(htmlFileName, cssFileName)
	
	htmlparser = HTMLParser.new(htmlFileName)
	htmlparser.read_file()
	htmlTree = htmlparser.parse()
	puts htmlTree	
end


if __FILE__ == $0
  puts "Initialized Engine \n+++++++++++++++++++++++++++++++++++++++++++"
  htmlFileName = ARGV[0]
  cssFileName = ARGV[1]
  runEngine(htmlFileName, cssFileName)
end