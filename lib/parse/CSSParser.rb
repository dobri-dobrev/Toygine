class CSSParser
  def initialize(file_path)
    @fr = FileReader.new(file_path)
  end
  def parse
    @fr.skip_white_space()
    
  end
end