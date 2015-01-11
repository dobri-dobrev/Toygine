#!/usr/bin/env ruby
require_relative 'util/FileReader'

require_relative 'parse/HTMLParser'
require_relative 'node/HTMLNode'

require_relative 'parse/CSSParser'
require_relative 'node/CSSSelector'
require_relative 'node/CSSRule'
require_relative 'node/CSSDeclaration'
require_relative 'node/CSSValue'



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