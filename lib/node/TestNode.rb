require_relative "BaseNode"

class TestNode < BaseNode
  attr_accessor :id, :title, :body
  def initialize
  	@id = @title = @body = nil
  	super(nil)
  end

end

t = TestNode.new()
t.add_child(TestNode.new())
t.add_child(TestNode.new())
t.add_child(TestNode.new())
puts t
