class MockFile
  def initialize(string_arr)
    @arr = string_arr
    @counter = 0
  end
  def readline
    if @counter >= @arr.length
      raise "Test looked for too many lines"
    end
    out = @arr[@counter]
    @counter += 1
    return out
  end
  def eof?
    if @counter < @arr.length
      return false
    end
    return true
  end
end