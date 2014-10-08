class Node
	attr_accessor :children, :node_type, :attributes, :text

	def initialize(name, attrs = nil, childr = nil, txt = nil)
		@node_type = name
		if name.eql? "text"
			# text node
			@text = txt
			@attributes = nil
			@children = nil
		else
			#element node
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
		#add attributes
		if not @attributes.nil?
			@attributes.each do |key, value|
				output_string += indent_string + key + " " + value + "\n"
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
		#print attributes
		if not @attributes.nil?
			@attributes.each do |key, value|
				puts indent_string + key + " " + value
			end
		end
		if not self.children.nil? and self.children.length > 0
			for child in self.children
				child.print_recursive(indent+1)
			end
		end
	end
end