class TreeNode
  attr_accessor :parent, :children, :value
  def initialze value
    @value = value
    @parent = nil
    @children = []
  end

  def parent= parent_node
    unless self.parent.nil?
      self.parent.children.delete(self)
    end
    parent_node.children << self
    self.parent = parent_node
  end

end
