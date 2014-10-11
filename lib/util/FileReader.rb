class FileReader
  @eof = false
  def initialize(file_path)
    @path = file_path
    @file = File.new(@path, "r")
    if !@file.eof?
      @line = @file.readline()
      @len = @line.length
      @cursor = 0
    else
      @eof = true
    end
  end

  def consume_and_advance
    char = current_char()
    consume_next_obl()
    return char
  end

  def consume_next_obl
    char = ''
    if @cursor + 1 < @len
      @cursor += 1
      char = @line[@cursor]
      return char
    else
      @cursor += 1
      if @file.eof?
        raise "Malformed input"
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
    raise "Malformed input"
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