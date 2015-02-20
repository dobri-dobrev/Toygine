class Node
  attr_accessor :children, :node_type, :attributes, :text

  def initialize(name, attrs = nil, childr = nil, txt = nil)
    case name
    when "text"
      @node_type = HTMLNodeType::TEXT
    when "html"
      @node_type = HTMLNodeType::HTML
    when "body"
      @node_type = HTMLNodeType::BODY
    when "head"
      @node_type = HTMLNodeType::HEAD
    when "link"
      @node_type = HTMLNodeType::LINK
    when "script"
      @node_type = HTMLNodeType::SCRIPT
    when "img"
      @node_type = HTMLNodeType::IMG
    when "a"
      @node_type = HTMLNodeType::A
    when "div"
      @node_type = HTMLNodeType::DIV
    when "p"
      @node_type = HTMLNodeType::P
    end
    if name.eql? "text"
      # case text node
      @text = txt
      @attributes = nil
      @children = nil
    else
      # case element node
      @text = txt
      if childr.nil?
        @children = []
      else
        @children = childr
      end
      if attrs.nil?
        @attributes = {}
      else
        @attributes = attrs
      end
    end
  end
  
  def add_child(child)
    #TODO type checking
    @children << child
  end
  
  def to_s()
    output_string = recursive_to_s(0)
    output_string
  end

  def recursive_to_s(indent)
    output_string = ""
    indent_string = ""
    i = 0
    while i < indent
      indent_string += "\t"
      i += 1
    end
    output_string += indent_string + @node_type +"\n"
    if @node_type.eql? "text"
      output_string += indent_string + "innerText: " + @text + "\n"
    end
    #add attributes
    if not @attributes.nil?
      @attributes.each do |key, value|
        output_string += indent_string + "attr: " + key + " val: " + value + "\n"
      end
    end
    if not self.children.nil? and self.children.length > 0
      for child in self.children
        output_string += child.recursive_to_s(indent+1)
      end
    end
    output_string
  end

  def print()
    print_recursive(0)
  end

  def print_recursive(indent)
    indent_string = ""
    i = 0
    while i < indent
      indent_string += "\t"
      i += 1
    end
    puts indent_string + @node_type
    if @node_type.eql? "text"
      puts indent_string + " innerText: " + @text
    end
    #print attributes
    if not @attributes.nil?
      @attributes.each do |key, value|
        output_string += indent_string + "attr: " + key + " val: " + value + "\n"
      end
    end
    if not self.children.nil? and self.children.length > 0
      for child in self.children
        child.print_recursive(indent+1)
      end
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