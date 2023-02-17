class Node
    include Comparable
    attr_accessor :data, :left, :right
    def initialize(data, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end
    def <=>(other)
      self.data <=> other.data
    end
end
  
class Tree 
    def initialize(arr = [])
      @arr = arr
      @root = build_tree
    end
  
    def build_tree(arr = @arr)
      return nil if arr.empty?
      arr = arr.uniq.sort
      mid = arr.length / 2
      root = Node.new(arr[mid])
      root.left = build_tree(arr[0...mid])
      root.right = build_tree(arr[mid+1..-1])
      return root
    end
  
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
  
    def insert(value, node = @root)
      if node.nil?
        return Node.new(value)
      elsif value < node.data
        node.left = insert(value, node.left)
      elsif value > node.data
        node.right = insert(value, node.right)
      else
        return node
      end
      return node
    end
  
    def delete(value)
      return nil if @root.nil?
      replacee = find_node(value, @root)
      return nil if replacee.nil?
  
      #remove end node
      if replacee.left.nil? && replacee.right.nil?
        remove_end_node(replacee)
      #remove 1 child node
      elsif replacee.left.nil?
        replace_node(replacee, replacee.right)
      elsif replacee.right.nil?
        replace_node(replacee, replacee.left)
      else
        replacer = find_successor(node)
        replace_node(replacee, replacer)
      end
    end
      
    private

    def find_node(value, node)
        if node.nil?
          return nil
        elsif node.data == value
          return node
        elsif value < node.data
          find_node(value, node.left)
        else
          find_node(value, node.right)
        end
    end
  
    def remove_end_node(node)
        parent = parent_finder(node)
        @root = nil if parent.nil?
        if node == parent.left
          parent.left = nil
        else 
          parent.right = nil
        end
    end
  
    def parent_finder(node)
        return nil if node == @root
        parent = @root
        child = parent.data < node.data ? parent.right : parent.left
        while child
          if child == node
            return parent
          end
          parent = child
          child = parent.data < node.data ? parent.right : parent.left
        end
        return nil
    end
  
    def find_successor(node)
        successor = node.right
        while successor
          successor = successor.left
        end
        return successor
    end
  
    def replace_node(replacee, replacer)
        parent = parent_finder(replacee)
        if parent.nil?
          @root = replacer
        elsif parent.right == replacee
          parent.right = replacer
        else 
          parent.left = replacer
        end
        replacee.right = replacer.right
        replacee.left = replacer.left
    end
end

  
  array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
  my_tree = Tree.new(array)
  puts my_tree.pretty_print
  puts my_tree.delete(23)
  puts my_tree.pretty_print
  