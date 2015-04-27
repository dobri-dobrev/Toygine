class StyleTransformer
  def self.matches_simple_selector(html_node, selector)
    if selector.tag_names[0] and !selector.tag_names[0].eql? html_node.type
      return false
    end
    for cl in selector.classes
      if html_node.classes[cl] == nil 
        return false
      end
    end
    if selector.ids[0] and html_node.id != selector.ids[0]
      return false
    end
    return true
  end

  #TODO extend for compound selector support
  def self.matches(html_node, selector)
    return self.matches_simple_selector(html_node, selector)
  end

  def self.match_rule(html_node, rule)
    rule.selectors.each { |selector| 
      if self.matches(html_node, selector)
        return MatchedRule.new(selector.specificity, rule)
      end
    }
    return nil
  end

  def self.matched_rules(html_node, rules)
    matched_rules = []
    rules.each { |rule|
      mr = self.match_rule(html_node, rule)
      if !mr.nil?
        matched_rules << mr
      end
    }
    return matched_rules
  end

  def self.get_sorted_matched_rules(html_node, rules)
    matched_rules = self.matched_rules(html_node, rules)
    matched_rules.sort_by!{|mr| mr.specificity}
    return matched_rules
  end

  def self.specified_values(html_node, rules)
    values = {}
    self.get_sorted_matched_rules(html_node, rules).each { |mr|
      mr.rule.declarations.each { |declaration|
        values[declaration.name.clone] = declaration.value.clone
        }
      }
    return values
  end

  def self.style_tree(html_node, rules)
    vals = self.specified_values(html_node, rules)
    st = StyleNode.new(html_node, vals)
    html_node.children.each { |child|
      st.add_child(StyleTransformer.style_tree(child, rules))
      }
    return st
  end
end