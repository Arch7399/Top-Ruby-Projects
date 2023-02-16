class Node
  @@size = 0
  attr_accessor :value, :next_node, :size
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
    @@size += 1
  end
end

class LinkedList
  attr_reader :head
  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      current_node = @head
      until current_node.next_node.nil?
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(value)
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    else
      prev_node = Node.new(value)
      prev_node.next_node = @head
      @head = prev_node
    end
  end

  def size
    count = 0
    current_node = @head
    until current_node.next_node.nil?
      count += 1
      current_node = current_node.next_node
    end
    count
  end

  def head
    @head  
  end

  def tail
    until @head.next_node.nil?
      @head = @head.next_node
    end
    @head.next_node
  end

  def at(index)
    count = 0
    current_node = @head
    until current_node.next_node.nil? || count == index
      current_node = current_node.next_node
      count += 1
    end
    current_node
  end

  def pop
    if @head.nil?
      nil
    elsif @head.next_node.nil?
      popped_node = @head
      @head = nil
      popped_node
    else
      current_node = @head
      until current_node.next_node.nil?
        current_node = current_node.next_node
      end
      popped_node = current_node
      current_node = nil
      popped_node
    end
  end

  def contains?(value)
    if @head.nil?
      false
    elsif @head.value == value
      true
    else
      current_node = @head.next_node
      until current_node.nil?
        return true if current_node.value == value
        current_node = current_node.next_node
      end
      false
  end

  def find(value)
    count = 0
    current_node = @head
    until current_node.nil?
      return count if current_node.value == value
      current_node = current_node.next_node
      count += 1
    end
    return nil
  end

  def to_s
    list_str = ""
    current_node = @head
    until current_node.nil?
      list_str += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    list_str += "nil"
    list_str
  end

  def insert_at(value, index)
    if index == 0
      new_node = Node.new(value)
      new_node.next_node = @head
      @head = new_node
    else
      current_node = @head
      (index - 1).times do
        current_node = current_node.next_node
        if current_node.nil?
          return "Your index is out of range, pass in a lesser index"
        end
      end
      new_node = Node.new(value)
      new_node.next_node = current_node.next_node
      current_node.next_node = new_node
    end
  end

  def remove_at(index)
    if @head.nil?
      return
    elsif index == 0
      @head = @head.next_node
    else
      current_node = @head
      (index-1).times do
        current_node = current_node.next_node
        if current_node.nil?
          return "Your index is out of range, pass in a lesser index"
        end
      end
      if current_node.next_node.nil?
          return "Your index is out of range, pass in a lesser index"
        end
      current_node.next_node = current_node.next_node.next_node
    end
  end
end
