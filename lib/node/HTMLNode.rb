class Node
  attr_accessor :children, :type, :attributes, :text

  def initialize(name, attrs = nil, childr = nil, txt = nil)
    case name
    when "text"
      @type = HTMLNodeType::TEXT
    when "html"
      @type = HTMLNodeType::HTML
    when "body"
      @type = HTMLNodeType::BODY
    when "head"
      @type = HTMLNodeType::HEAD
    when "link"
      @type = HTMLNodeType::LINK
    when "script"
      @type = HTMLNodeType::SCRIPT
    when "img"
      @type = HTMLNodeType::IMG
    when "a"
      @type = HTMLNodeType::A
    when "div"
      @type = HTMLNodeType::DIV
    when "p"
      @type = HTMLNodeType::P
    else
      raise "Unsupported node type"
    end
    @attributes = {}
    @children = []
    @text = txt  
    if !childr.nil?
      @children = childr
    end
    if !attrs.nil?
      @attributes = attrs
    end
  end
  
  def add_child(child)
    #TODO type checking
    @children << child
  end

  def to_s
    output_string = @type +"\n"
    if @type.eql? "text"
      output_string += "innerText: " + @text + "\n"
    end
    #add attributes
    if not @attributes.nil?
      @attributes.each do |key, value|
        output_string += "attr: " + key + " val: " + value + "\n"
      end
    end
    #add children
    if self.children.length > 0
      for child in self.children
        output_string += child.recursive_to_s(indent+1)
      end
    end
    return output_string
  end

  def print
    print_recursive(0)
  end

  def id
    if @attributes["id"]
      return attributes["id"]
    else
      return nil
    end
  end

  def classes
    if @attributes["class"]
      return_hash = {}
      @attributes["class"].split(" ").each{ |cl| return_hash[cl] = true}
      return return_hash
    else
      return nil
    end
  end

  def print_recursive(indent)
    indent_string = ""
    i = 0
    while i < indent
      indent_string += "\t"
      i += 1
    end
    puts indent_string + @type
    if @type.eql? "text"
      puts indent_string + "innerText: " + @text
    end
    #print attributes
    @attributes.each do |key, value|
      puts indent_string + "attr: " + key + " val: " + value + "\n"
    end
    for child in self.children
      child.print_recursive(indent+1)
    end
  end
end

module HTMLNodeType
  HTML = "html"
  BODY = "body"
  HEAD = "head"
  LINK = "link"
  SCRIPT = "script"
  IMG = "img"
  A = "a"
  DIV = "div"
  TEXT = "text"
  P = "p"
end