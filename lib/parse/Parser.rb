class Parser
	attr_accessor :name, :fileString, :position
	def initialize(input_name)
		puts "Initialized parser \n+++++++++++++++++++++++++++++++++++++++++++"
		@name = input_name
		@position = 0
		@fileString = ''
	end

	def read_file()
		fileObj = File.new(@name, "r")
		#TO DO: rather than concatenate the whole file in RAM, read line by line 
		fileObj.each_line do |line|
			@fileString += line
		end
		fileObj.close
	end

	def parse()
		skip_white_space()
		if is_at_beginning_of_element()
			htmlNode = parse_node_rec()
			htmlNode.print()
		else
			raise "Malformed HTML"
		end
	end

	private 
		
		def parse_node_rec()
			node = nil
			skip_white_space()
			if @fileString[@position].eql? "<"
				#case it is an element
				#skip <
				@position += 1
				skip_white_space()
				nodeType = consume_word()
				nodeAttributes = consume_attributes()
				node = Node.new(nodeType, nodeAttributes)
				skip_white_space()
				if @fileString[@position].eql? "/" and @fileString[@position+1].eql? ">"
					#case < .. /> tag type
					@position += 2
					skip_white_space()
				else
					#case < .. > </ .. > tag type
					@position += 1
					skip_white_space()
					while @position < @fileString.length and not is_at_closing_of_element()
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
			while @fileString[@position] =~ /[[:alpha:]]|[[:digit:]]|\s|\.|\-|\*|\,|\:|\!|\?/
				text += @fileString[@position]
				@position += 1
			end
			text
		end

		def consume_attributes()
			attributes = {}
			#TODO actually consume attributes
			skip_white_space()
			while not (@fileString[@position].eql? ">" or (@fileString[@position].eql? "/" and @fileString[@position+1].eql? ">") )
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
			@position += 1 #skip =
			skip_white_space()
			value = consume_attribute_value()
			puts identifier
			puts value
			return [identifier, value]
		end

		def consume_attribute_value()

			if @fileString[@position].eql? '"'
				@position += 1
				value = ""
				while not @fileString[@position].eql? '"'
					value += @fileString[@position]
					@position += 1
				end
				@position += 1 #skip over "
				return value
			end
			if @fileString[@position].eql? "'"
				@position += 1
				value = ""
				while not @fileString[@position].eql? "'"
					value += @fileString[@position]
					@position += 1
				end
				@position += 1 #skip over '
				return value
			end
			raise "Malformed identifier expression"
		end

		def consume_closing_tag()
			while not @fileString[@position].eql? ">"
				@position += 1
			end
			@position += 1
		end

		def consume_word()
			word = ""
			while @position < @fileString.length and @fileString[@position] =~ /[[:alpha:]]|[[:digit:]]|_/
				word += @fileString[@position]
				@position += 1
			end
			word
		end

		def is_at_beginning_of_element()
			return ( @position < @fileString.length and @fileString[@position].eql? "<" and ! @fileString[@position+1].eql? "/" )
		end

		def is_at_closing_of_element()
			return (@fileString[@position].eql? "<" and @fileString[@position+1].eql? "/" )
		end

		def skip_white_space()
			while @position < @fileString.length
				if @fileString[@position] =~ /\s|\n|\t/
					@position+=1
				else
					return
				end
			end
		end
end