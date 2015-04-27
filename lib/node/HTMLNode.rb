class Node < BaseNode
  attr_accessor :type, :attributes, :text

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
    @text = txt  
    if !attrs.nil?
      @attributes = attrs
    end
    super(childr)
  end
  
  def id
    if @attributes["id"]
      return attributes["id"]
    else
      return nil
    end
  end

  def classes
    return_hash = {}
    if @attributes["class"]
      @attributes["class"].split(" ").each{ |cl| return_hash[cl] = true}  
    end
    return return_hash
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