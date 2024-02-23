require_relative "./lib/tree"

array = [20, 30, 40, 50, 60, 70]
the_tree = Tree.new(array)

p the_tree.root

puts ""
the_tree.pretty_print

# -------------------------------------------------------------- INSERT NODES
node_to_insert = 80
puts "\ninserting node: #{node_to_insert}"
the_tree.insert(node_to_insert)
node_to_insert = 90
puts "\ninserting node: #{node_to_insert}"
the_tree.insert(node_to_insert)

puts ""
the_tree.pretty_print

# -------------------------------------------------------------- REMOVE NODES
node_to_remove = 80
puts "\nremoving node: #{node_to_remove}"
the_tree.delete(node_to_remove)

puts ""
the_tree.pretty_print

# -------------------------------------------------------------- PRE, IN, POSTORDER

puts "\npreorder"
the_tree.preorder

puts "\ninorder"
the_tree.inorder

puts "\npostorder"
the_tree.postorder

# -------------------------------------------------------------- FIND

node_to_find = 60
puts "\nfind #{node_to_find}"
p the_tree.find(node_to_find)

# -------------------------------------------------------------- LEVEL ORDER
puts "\nlevel_order with &block"
the_tree.level_order do |node|
  puts "este nodo es la polla --> #{node.data}"
end

puts "\nlevel_order NO &block"
nodes_array = the_tree.level_order
nodes_array.each { |node| p node }

puts "\nlevel_order_recursion with &block"
the_tree.level_order_recursion do |node|
  puts "este nodo es la polla --> #{node.data}"
end

puts "\nlevel_order_recursion NO &block"
nodes_array = the_tree.level_order_recursion
nodes_array.each { |node| p node }

# -------------------------------------------------------------- DEPTH
puts ""
the_tree.pretty_print

puts "\nDepth 70"
p the_tree.depth(70)

puts "\nDepth 90"
p the_tree.depth(90)

puts "\nDepth 60"
p the_tree.depth(60)

puts "\nDepth 75"
p the_tree.depth(75)

the_tree.insert(100)
puts ""
the_tree.pretty_print

puts "\nDepth 100"
p the_tree.depth(100)

# -------------------------------------------------------------- HEIGHT
puts "\nHeight 70"
p the_tree.height(70)

puts "\nHeight 50"
p the_tree.height(50)

the_tree.insert(110)
puts ""
the_tree.pretty_print

puts "\nHeight 50"
p the_tree.height(50)

# -------------------------------------------------------------- BALANCED?
puts "\nBalanced ?"
p the_tree.balanced?

puts "\nNEW TREE"
array = [20, 30, 40, 50, 60, 70]
the_tree = Tree.new(array)
puts ""
the_tree.pretty_print

puts "\nBalanced ?"
p the_tree.balanced?

the_tree.insert(55)
puts ""
the_tree.pretty_print

puts "\nBalanced ?"
p the_tree.balanced?

the_tree.insert(100)
the_tree.insert(110)
the_tree.insert(120)
the_tree.insert(130)
puts ""
the_tree.pretty_print

puts "\nBalanced ?"
p the_tree.balanced?

# -------------------------------------------------------------- REBALANCED
puts "\nRebalance"
p the_tree.rebalance
puts ""
the_tree.pretty_print


# -------------------------------------------------------------- RANDOM CREATION
puts "\nCreate tree from random array"
array = (Array.new(15) { rand(1..100) })
p array
the_tree = Tree.new(array)
the_tree.pretty_print
