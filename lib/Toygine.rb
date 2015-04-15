#!/usr/bin/env ruby
require_relative 'util/FileReader'
require_relative 'util/Specificity'

require_relative 'parse/HTMLParser'
require_relative 'node/HTMLNode'

require_relative 'parse/CSSParser'
require_relative 'node/CSSSelector'
require_relative 'node/CSSRule'
require_relative 'node/CSSDeclaration'
require_relative 'node/CSSValue'



def runEngine(htmlFileName, cssFileName)
  html_file_reader = FileReader.new(File.new(htmlFileName, "r"), htmlFileName)
  htmlparser = HTMLParser.new(html_file_reader)
  htmlTree = htmlparser.parse()
  for css in htmlparser.get_css(htmlTree)
    puts css
  end
  htmlTree.print()
end


if __FILE__ == $0
  puts "Initialized Engine \n+++++++++++++++++++++++++++++++++++++++++++"
  htmlFileName = ARGV[0]
  cssFileName = ARGV[1]
  runEngine(htmlFileName, cssFileName)
end