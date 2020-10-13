class PolyTreeNode
    attr_reader :value, :parent, :children
    attr_writer :parent, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = [] 
    end

    def parent=(new_parent)#parent
        return @parent = nil if new_parent.nil? #if we have no paren
        unless new_parent.children.include?(self)
            new_parent.children << self 
            @parent.children.delete(self) unless @parent.nil?
            @parent = new_parent 
        end 
    end

    def add_child(new_child)
        new_child.parent = self
        new_child
    end


    def remove_child(child)
        raise "The #{child.value} node is not a child" unless self.children.include?(child)
        child.parent = nil #become to empty disconnect from paret
        @children.delete(child) #delet child from child
    end

    def inspect
        "<***#{@value}, with children #{@children}***>"
    end
# require "byebug"
    def dfs(val)
        return self if self.value == val #check parent
        # @children.inject(nil) {|result, child| child.dfs(val) || result} 
        @children.each do |child|
            res = child.dfs(val)
            return res unless res.nil?
        end
        nil
    end
    
        # return nil if children.empty?
        # debugger    

    
    def bfs(val) 
        queue = [self]  

        until queue.empty? 
            if queue.first.value == val
                return queue.first
            else
                queue.concat(queue.shift.children) #you add [] + children's children
            end
        end
        nil #if noting == val
    end
    # end
    #  nil
    #   \
    #    1                  [[1 [[2,[[5, []], 6]], [3, [8]]]]
    #   / \
    #   2  3 
    #  / \  \
    # 5   6  8
        # other-parent    root
        #    /         \    
        # child1       child2


    # enqueue adds last
    # deque removes front

end



# child.children child = PolyTreeNode.new(8)

# child.value => 8
# child.parent => nil
# child.children => []

# parent_node = PolyTreeNode.new(2)
# parent_node.value => 2
# parent_node.parent => nil
# parent_node.children => []

# child.parent=(parent_node)# ↓　happenes after this method

# child.value => 8
# child.parent => parent_node
# child.children => []

# parent_node.value => 2
# parent_node.parent => nil
# parent_node.children => [child, charleu, thegue, happyface]
# child.children >> []
# parent_node.children.each {|child| p child.children}





# ################
# knight_pos1
#         @value = [0,0]
#         @parent = nil
#         @children = []


# next_pos
#     @value = [2,1]
#     @parent = nil
#     @children = []

# knight_pos1.add_child(next_pos)

# knight_pos1
#         @value = [0,0]
#         @parent = nil
#         @children = [next_pos]

# next_pos
#     @value = [2,1]
#     @parent = knight_pos1
#     @children = []

