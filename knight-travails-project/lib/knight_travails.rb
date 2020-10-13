require_relative "00_tree_node.rb"
# require "byebug"

class KnightPathFinder
    attr_reader :root_node, :used_pos
    #BOARD => constant(cannot change)
    @@board = Array.new(8) {Array.new(8, "_")} #class variable: can use it for entire class 

    def self.valid_moves(current_pos)
        pos_steps = [2, 1, -2, -1].permutation(2).select {|ele| ele.sum.odd?}
        valid_pos = []
        pos_steps.each do |ele|
            row = current_pos[0] + ele[0]
            col = current_pos[1] + ele[1]
            if row >= 0 && row < 8 
                if col >= 0 && col < 8
                    valid_pos << [row, col] if row
                end
            end 
        end
        valid_pos
    end 
    # [pos1, pos2, pos3]
    # col  row
    #  2    1
    #  2    -1
    #  -2    1
    #  -2    -1
    #  1      2
    #  1     -2
    #  -1     2
    #   -1    -2
    def initialize (starting_pos)
        # @starting_pos = starting_pos
        @root_node = PolyTreeNode.new(starting_pos)
        # kpf = KnightPathFinder.new([0, 0])
        @used_pos = [starting_pos]
    end

    def new_move_position(current_pos) #
        next_pos = KnightPathFinder.valid_moves(current_pos)# =>[pos2, pos3, pos4] NEXT POS
        next_pos.select {|ele| !@used_pos.include?(ele) }
    end

    def build_move_tree
        nodes = [@root_node]
        until nodes.empty?
            # debugger
            current_node = nodes.first
            current_pos = current_node.value
            positions = new_move_position(current_pos) # [[5, 4], [5, 2], [4, 5], [4, 1], [1, 4], [1, 2], [2, 5], [2, 1]]
            next_nodes = positions.map do |pos| 
                @used_pos << pos
                next_node = PolyTreeNode.new(pos)
                current_node.add_child(next_node)
                next_node
            end
            nodes.concat(next_nodes)
            nodes.shift
        end
        @root_node
    end

    def find_path(end_pos)
        start_node = build_move_tree
        end_node = start_node.bfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        node = end_node
        path =[end_node.value] #last pos

        until node.parent.nil? 
            node = node.parent
            path << node.value #add pos
        end
        path.reverse
    end

end


# kpf = KnightPathFinder.new([0, 0])