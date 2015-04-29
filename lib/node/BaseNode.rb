class BaseNode
  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end
  
  def initialize(c)
    @children = c.nil? ? [] : c
  end
  def self.attributes
    @attributes
  end

  def children()
    return @children
  end

  def add_child(child)
    @children << child
  end

  def attributes
    self.class.attributes
  end

  def reset_children
    @children = []
  end

  def to_s
    return recursive_to_s(0)
  end

  def recursive_to_s(indent)
    i = 0
    indent_string = ""
    unless indent == 0
      (0..indent).each{
        indent_string += "\t"
      }  
    end
    
    output_string = indent_string + "NODE:\n"
    self.class.attributes.each { |e| 
      if instance_variable_get("@"+e.to_s).is_a? BaseNode
        output_string += indent_string + e.to_s + ": " + "\n" + instance_variable_get("@"+e.to_s).inline_to_s(indent_string + "  ")
      else
        output_string += indent_string + e.to_s + ": " + instance_variable_get("@"+e.to_s).to_s  + "\n"
      end
    }
    #add children
    if self.children.length > 0
      for child in self.children
        output_string += child.recursive_to_s(indent+1)
      end
    end
    return output_string
  end

  def inline_to_s(indent_string)
    output_string = ""
    counter = 0
    self.class.attributes.each{ |e|
      counter += 1
      if !e.to_s.eql? "children"
        output_string += indent_string + e.to_s + ": " + instance_variable_get("@"+e.to_s).to_s  + "\n"
      end
    }
    return output_string
  end

  def print
    puts self.to_s
  end
end