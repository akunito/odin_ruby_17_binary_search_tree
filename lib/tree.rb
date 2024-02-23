# https://www.theodinproject.com/lessons/ruby-binary-search-trees

@debug = true

def log(string)
  puts string if @debug
end

module Comparable
  def comparable(node1, node2)
    return unless node1.left && node1.right && node2.left && node2.right

    puts "\t\t\t\t_____Node_1_____||_____Node_2______"
    puts
    puts "\tdata:\t\t\t\t#{node1.data}\t\t||\t\t#{node2.data}"
    puts "\t\t\t\t\t#{node1.left.data}\t|\t#{node1.right.data}\t||\t#{node2.left.data}   |   #{node2.right.data}"
    puts
  end
end

class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root, :left, :right, :data

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return unless array.length.positive?

    # find middle index
    mid = array.length/2

    # make the middle element the root
    root = Node.new(array[mid])

    # left subtree of root has all values < mid
    root.left = build_tree(array[0, mid])

    # right subtree of root has all values > mid
    root.right = build_tree(array[mid+1, array.length])

    root
  end

  def pretty_print(node=@root, prefix='', is_left=true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, root=@root)
    return Node.new(data) unless root

    if root.data == data
      root
    elsif root.data < data
      root.right = insert(data, root.right)
    else
      root.left = insert(data, root.left)
    end
    root
  end

  def zero_or_one_child(root)
    if !root.left
      puts "only LEFT child nil"
      root.right
    elsif !root.right
      puts "only RIGHT child nil"
      root.left
    end
  end

  def both_children(root)
    succ_parent = root

    # Find successor
    succ = root.right
    until succ.left.nil?
      succ_parent = succ
      succ = succ.left
    end
    puts "succ.data -> #{succ.data}"
    # Delete successor. Since successor is always left child of its parent
    # we can safely make successor's right -> right child as left of its parent.
    # If there is no succ, then assign succ.right to succ_parent.right
    if succ_parent != root
      succ_parent.left = succ.right
    else
      succ_parent.right = succ.right
    end

    # Copy Successor Data to root
    root.data = succ.data

    # Delete Successor and return root
    root
  end

  def delete(data, root=@root)
    # base case
    return root if root.nil?

    # Recursive calls for ancestors of node to be deleted (pointing cursor)
    puts "\nROOT TARGET >>>> [#{root.data}]"
    if root.data > data
      puts "going left"
      root.left = delete(data, root.left)
      return root
    elsif root.data < data
      puts "going right"
      root.right = delete(data, root.right)
      return root
    end

    # We reach here when root (cursor) is the node to be deleted

    # 1. If one of the children is empty
    if !root.left || !root.right
      puts "\n>>>> ROOT IF 0 or 1 children >>>> [#{root.data}]"
      zero_or_one_child(root)

      # 2. If both children exist
    else
      puts "\n<<<< BOTH CHILDREN EXIST >>>> [#{root.data}]"
      both_children(root)
    end
  end

  def find(data, root=@root)
    # base case
    return root if root.nil?

    if root.data == data
      # puts "Node [#{data}] found"
      root
    elsif root.data > data
      # puts "going left"
      find(data, root.left)
    elsif root.data < data
      # puts "going right"
      find(data, root.right)
    end
  end

  def preorder(node=@root)
    return unless node

    p node
    preorder(node.left)
    preorder(node.right)
  end

  def inorder(node=@root)
    return unless node

    inorder(node.left)
    p node
    inorder(node.right)
  end

  def postorder(node=@root)
    return unless node

    postorder(node.left)
    postorder(node.right)
    p node
  end

  def level_order(nodes_array=[], node=@root)
    que = Queue.new
    return unless node

    que.push(node)

    until que.empty?
      next_node = que.pop

      block_given? ? (yield next_node) : (nodes_array << next_node)

      # queue linked nodes
      que.push(next_node.left) unless next_node.left.nil?
      que.push(next_node.right) unless next_node.right.nil?
    end
    nodes_array unless block_given?
  end

  def level_order_recursion(node=@root, nodes_array=[], &block)
    que = Queue.new
    return unless node

    # store root
    que.push(node)

    block_given? ? (yield que.pop) : (nodes_array << que.pop)

    # recall node.left
    level_order_recursion(node.left, nodes_array, &block) unless node.left.nil?
    # recall node.right
    level_order_recursion(node.right, nodes_array, &block) unless node.right.nil?
    nodes_array unless block_given?
  end

  def depth(data, root=@root, depth=0)
    # data is node's value
    # base case
    return if root.nil?

    # Recursive calls for ancestors of node to calculate (pointing cursor)
    # p root
    # puts "\nROOT TARGET >>>> [#{root.data}]"
    if root.data == data
      depth
    elsif root.data > data
      depth += 1
      depth(data, root.left, depth)
    elsif root.data < data
      depth += 1
      depth(data, root.right, depth)
    end
  end

  def height(data)
    target_node = find(data)
    leaf_node = level_order_recursion(target_node)[-1]

    depth(leaf_node.data, target_node)
  end

  def balanced?(root=@root)
    (height(root.left.data) - height(root.right.data)).between?(-1, 1)
  end

  def rebalance
    nodes = []
    level_order_recursion.each { |node| nodes << node.data }
    initialize(nodes)
  end
end