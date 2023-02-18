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

    def level_order(node=@root, &block)
        queue = []
        queue << node
        array = []
        while !queue.empty?
          dequeued = queue.shift
          if block_given?
            yield dequeued.data
          else
            array << dequeued
          end
          queue << dequeued.left if !dequeued.left.nil?
          queue << dequeued.right if !dequeued.right.nil?
        end
        return array if array.any?
    end

    def inorder(node=@root, &block)
      if node.nil?
        return
      end
      inorder(node.left, &block)
        yield node.data
      inorder(node.right, &block)
    end

    def preorder(node=@root, &block)
      if node.nil?
        return
      end
      yield node.data
      preorder(node.left, &block)
      preorder(node.right, &block)
    end

    def postorder(node=@root, &block)
      if node.nil?
        return
      end
      postorder(node.left, &block)
      postorder(node.right, &block)
      yield node.data
    end

    def print_traversals
      puts "Inorder traversal:"
      inorder { |data| puts data }
      puts "Preorder traversal:"
      preorder { |data| puts data }
      puts "Postorder traversal:"
      postorder { |data| puts data }
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
      else #rearrange 2 child nodes
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
  #my_tree.level_order do |data|
  #  sorted << data
  #end
  my_tree.print_traversals

  puts my_tree.pretty_print

  