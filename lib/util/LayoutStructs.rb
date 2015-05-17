class Dimensions < Struct.new(:content, :padding, :border, :margin)
	#content:Rect padding, border, and margin:EdgeSizes
end

class Rect < Struct.new(:x, :y, :width, :height)
	def expanded_by(edges)
		self.x -= edges.left
		self.y -= edges.top
		self.width += edges.left + edges.right
		self.height += edges.top + edges.bottom
	end
end

class EdgeSizes < Struct.new(:left, :right, :top, :bottom)
end

