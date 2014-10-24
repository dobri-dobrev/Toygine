#!/usr/bin/env ruby
require_relative 'parse/HTMLParser'
require_relative 'node/HTMLNode'
require_relative 'util/FileReader'
require_relative 'parse/CSSParser'
require_relative 'node/CSSSelector'



def runEngine(htmlFileName, cssFileName)
	
	htmlparser = HTMLParser.new(htmlFileName)
	htmlTree = htmlparser.parse()
	puts htmlTree	
end


if __FILE__ == $0
  puts "Initialized Engine \n+++++++++++++++++++++++++++++++++++++++++++"
  htmlFileName = ARGV[0]
  cssFileName = ARGV[1]
  runEngine(htmlFileName, cssFileName)
end