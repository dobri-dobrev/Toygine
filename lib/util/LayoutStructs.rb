class Dimensions < Struct.new(:content, :padding, :border, :margin)
	#content:Rect padding, border, and margin:EdgeSizes
	def padding_box()
		self.content.expanded_by(self.padding)
	end
	def border_box()
		self.padding_box().expanded_by(self.border)
	end
	def margin_box()
		self.border_box().expanded_by(self.margin)
	end
end

class Rect < Struct.new(:x, :y, :width, :height)
	def expanded_by(edges)
		x = self.x - edges.left
		y = self.y - edges.top
		width = self.width + edges.left + edges.right
		height = self.height + edges.top + edges.bottom
		Rect.new(x, y, width, height)
	end
end

class EdgeSizes < Struct.new(:left, :right, :top, :bottom)
end

