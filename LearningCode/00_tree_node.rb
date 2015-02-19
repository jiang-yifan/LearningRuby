class PolyTreeNode
  attr_accessor :parent, :children, :value
  def initialize value
    @value = value
    @parent = nil
    @children = []
  end

  def parent= parent_node
    if parent_node.nil?
      @parent = nil
      return
    end

    unless self.parent.nil?
      self.parent.children.delete(self)
    end
    parent_node.children << self
    @parent = parent_node
  end

  def add_child(child)
    self.children << child
    child.parent = self
  end

  def remove_child(child)
    raise "Not a child!" unless self.children.delete(child)
    child.parent = nil
  end

   def dfs(target_value)
     return self if target_value == value
     children.each do |child|
       found_node = child.dfs(target_value)
       return found_node if found_node
     end
     nil
   end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each do |child|
        queue << child
      end
    end

  end

end

#  a = PolyTreeNode.new('a')
#  b = PolyTreeNode.new('b')
#  c = PolyTreeNode.new('c')
#  d = PolyTreeNode.new('d')
#
#  a.add_child(b)
#  a.add_child(c)
#  b.add_child(d)
#
# a.dfs('c')


# node1 = PolyTreeNode.new('node1')
# node2 = PolyTreeNode.new('node2')
#
# node2.parent = node1
# p node2.parent
