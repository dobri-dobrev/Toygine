class CSSSelector
	attr_accessor :id, :class, :tag_type
	def initialize(i , c , t )
		@id = i
		@class = c
		@tag_type = t
	end

	def to_s
		out = ""
		unless @id.nil? 
			out += "id: " + @id 
		end
		unless @class.nil? 
			out += "class: " + @class
		end
		unless @tag_type.nil? 
			out += "tag_type: " + @tag_type 
		end
		return out
	end
end

