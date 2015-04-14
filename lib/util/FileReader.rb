class FileReader
  attr_accessor :path
  @eof = false
  def initialize(file_in, file_path)
    @path = file_path
    @file = file_in
    if !@file.eof?
      @line = @file.readline()
      @len = @line.length
      @cursor = 0
    else
      @eof = true
    end
  end
  
  def skip_white_space
    while has_next()
      if current_char() =~ /\s|\n|\t/
        consume_next_obl()
      else
        return
      end
    end
  end

  def consume_word
    word = ""
    word += current_char()
    while has_next() and next_char() =~ /[[:alpha:]]|[[:digit:]]|_|-/
      word += consume_next_obl()
    end
    if has_next()
      consume_next_obl()  
    end
    return word
  end

  def consume_next_obl
    if @cursor + 1 < @len
      @cursor += 1
      char = @line[@cursor]
      return char
    else
      @cursor += 1
      if @file.eof?
        raise "Malformed input in " + @path
      end
      @line = @file.readline()
      @len = @line.length
      @cursor = 0
      char = @line[@cursor]
      return char  
    end
  end

  def skip_character
    if @cursor + 1 < @len
      @cursor += 1
      char = @line[@cursor]
      return char
    else
      @cursor += 1
      if @file.eof?
        raise "Malformed input in " + @path
      end
      @line = @file.readline()
      @len = @line.length
      @cursor = 0
      char = @line[@cursor]
      return char  
    end
  end

  def current_char
    return @line[@cursor]
  end
  def next_char
    if has_next() && @cursor + 1 < @len
      return @line[@cursor + 1]
    end
    raise "Malformed input in " + @path
  end
  
  def has_next
    if @cursor + 1 < @len
      return true
    end
    if @file.eof?
      @eof = true
      return false
    end
    return true
  end
end