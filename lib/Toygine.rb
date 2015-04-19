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
require_relative 'node/StyleNode'
require_relative 'transform/StyleTransformer'
require_relative 'transform/MatchedRule'



def runEngine(htmlFileName)
  folder_location = get_folder_location(htmlFileName)
  html_file_reader = FileReader.new(File.new(htmlFileName, "r"), htmlFileName)
  htmlparser = HTMLParser.new(html_file_reader)
  htmlTree = htmlparser.parse()
  for css_path in htmlparser.get_css(htmlTree)
    path = folder_location + css_path
    cp = CSSParser.new(FileReader.new(File.new(path, "r"), path ))
    cl = cp.parse()
    for rule in cl
      puts rule
    end
  end
  htmlTree.print()
end

def get_folder_location(htmlFileName)
  arr = htmlFileName.split('/')
  index = 0
  folder_location = ""
  while index < arr.length - 1
    folder_location += arr[index] + "/"
    index += 1
  end
  return folder_location
end


if __FILE__ == $0
  puts "Initialized Engine \n+++++++++++++++++++++++++++++++++++++++++++"
  htmlFileName = ARGV[0]
  runEngine(htmlFileName)
end