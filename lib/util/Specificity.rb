class Specificity;
	include Comparable
	attr_accessor :id, :cl, :ta
	def initialize(a, b, c)
		@id = a
		@cl = b
		@ta = c
	end

	def <=>(other)
		if 0 != (@id <=> other.id)
			return @id <=> other.id
		end
		if 0 != (@cl <=> other.cl) 
			return @cl <=> other.cl
		end
		return @ta <=> other.ta
	end

	def eql?(other)
		return (@id == other.id and @cl == other.cl and @ta == other.ta)
	end

	def to_s
		"("+ @id.to_s + ", " + @cl.to_s + ", " + @ta.to_s + ")" 
	end
end