class LayoutTransformer
  def self.build_layout_tree(style_node)
    root = ""
    case style_node.display()
    when Display::INLINE
      root = LayoutBox.new(nil, BoxType::INLINE_NODE, style_node, [])
    when Display::BLOCK
      root = LayoutBox.new(nil, BoxType::BLOCK_NODE, style_node, [])
    when Display::NONE
      raise "managerial node has display none"
    end
    style_node.children.each { |child|
      case child.display()
      when Display::INLINE
        root.get_inline_container().add_child(self.build_layout_tree(child))
      when Display::BLOCK
        root.add_child(self.build_layout_tree(child))
      when Display::NONE
        
      end
    }
    return root
  end
end