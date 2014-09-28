require 'test/unit'
require_relative '../lib/Toygine'

class NodePrintTest <Test::Unit::TestCase
	def test_print
		child1 = Node.new("child1")
		gchild1 = Node.new("gchild1")
		gchild2 = Node.new("gchild2")
		child2 = Node.new("child2", {}, [gchild1, gchild2])
		parent = Node.new("parent", {}, [child2, child1])
		parent.print()
	end
end