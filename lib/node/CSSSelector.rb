class CSSSelector
	attr_accessor :ids, :classes, :tag_names
	def initialize
		@ids = []
		@classes = []
		@tag_names = []
	end

	def add_tag(type, tag)
		case type
		when CSSSelectorType::ID
			@ids.push(tag)
		when CSSSelectorType::CLASS
			@classes.push(tag)
		when CSSSelectorType::TAG_NAME
			@tag_names.push(tag)
		end	
	end

	def to_s
		out = ""
		for id in @ids
			out += id + " "
		end
		for classe in @classes
			out += classe + " "
		end
		for tag_name in @tag_names
			out += tag_name + " "
		end
		if out.eql? ""
			out = "empty selector"
		end
		return out
	end
end

module CSSSelectorType
	ID = "id"
	CLASS = "class"
	TAG_NAME = "tag_name"
end