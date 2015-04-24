class Dimensions < Struct.new(:content, :padding, :border, :margin)
end

class Rect < Struct.new(:x, :y, :width, :height)
end

class EdgeSizes < Struct.new(:left, :right, :top, :bottom)
end

