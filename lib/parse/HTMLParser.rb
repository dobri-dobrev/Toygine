class HTMLParser
  attr_accessor :name, :fileString, :position
  def initialize(file_path)
  	@name = file_path
  	@fr = FileReader.new(@name)
  end

  def parse()
  	skip_white_space()
  	if is_at_beginning_of_element()
  		htmlNode = parse_node_rec()
  		return htmlNode
  	else
  		raise "Malformed HTML"
  	end
  end

  private 
  	
	def parse_node_rec()
		node = nil
		skip_white_space()
		if @fr.current_char().eql? "<"
			#case it is an element
			#skip <
			@fr.consume_next_obl()
			skip_white_space()
			nodeType = consume_word()
			nodeAttributes = consume_attributes()
			node = Node.new(nodeType, nodeAttributes)
			skip_white_space()
			if @fr.current_char().eql? "/" and @fr.next_char().eql? ">"
				#case < .. /> tag type
				@fr.consume_next_obl()
        @fr.consume_next_obl()
				skip_white_space()
			else
				#case < .. > </ .. > tag type
        @fr.consume_next_obl()
				skip_white_space()
				while @fr.has_next() and not is_at_closing_of_element()
					skip_white_space()
					node.add_child(parse_node_rec())
				end
				#TODO assert that closing tag is of right type
				consume_closing_tag()
				skip_white_space()
			end
		else
			#case it is a text node
			nodeText = consume_text()
			node = Node.new("text", nil, nil, nodeText)
			skip_white_space()
		end
		node
	end

	def consume_text()
		text = ""
		while @fr.has_next() and
      @fr.current_char() =~ /[[:alpha:]]|[[:digit:]]|\s|\.|\-|\*|\,|\:|\!|\?/
			text += @fr.current_char()
			@fr.consume_next_obl()
		end
		text
	end

	def consume_attributes()
		attributes = {}
		#TODO actually consume attributes
		skip_white_space()
		while not (@fr.current_char().eql? ">" or (@fr.current_char().eql? "/" and @fr.next_char().eql? ">") )
			tuple = consume_attribute_pair()
			attributes[tuple[0]] = tuple[1]
			skip_white_space()
		end
		attributes
	end

	def consume_attribute_pair()
		#TODO handle bad input

		identifier = consume_word()
		skip_white_space()
		@fr.consume_next_obl() #skip =
		skip_white_space()
		value = consume_attribute_value()
		return [identifier, value]
	end

	def consume_attribute_value()

		if @fr.current_char().eql? '"'
			@fr.consume_next_obl()
			value = ""
			while not @fr.current_char().eql? '"'
				value += @fr.consume_and_advance()
			end
			@fr.consume_next_obl() #skip over "
			return value
		end
		if @fr.current_char().eql? "'"
			@fr.consume_next_obl()
			value = ""
			while not @fr.current_char().eql? "'"
				value += @fr.consume_and_advance()
			end
			@fr.consume_next_obl() #skip over '
			return value
		end
		raise "Malformed identifier expression"
	end

	def consume_closing_tag()
		while not @fr.current_char().eql? ">"
			@fr.consume_next_obl()
		end
    if @fr.has_next
      @fr.consume_next_obl()  
    end
	end

	def consume_word()
		word = ""
		while @fr.has_next() and @fr.current_char() =~ /[[:alpha:]]|[[:digit:]]|_/
			word += @fr.consume_and_advance()
		end
		word
	end

	def is_at_beginning_of_element()
		return ( @fr.has_next() and @fr.current_char().eql? "<" and ! @fr.next_char().eql? "/" )
	end

	def is_at_closing_of_element()
		return (@fr.current_char().eql? "<" and @fr.next_char().eql? "/" )
	end

	def skip_white_space()
		while @fr.has_next()
			if @fr.current_char() =~ /\s|\n|\t/
				@fr.consume_next_obl()
			else
				return
			end
		end
  end
end