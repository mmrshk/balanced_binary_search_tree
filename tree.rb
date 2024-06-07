class AVLTreeNode
  attr_accessor :key, :left, :right, :height

  def initialize(key)
    @key = key
    @left = nil
    @right = nil
    @height = 1
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def height(node)
    node ? node.height : 0
  end

  def balance_factor(node)
    height(node.left) - height(node.right)
  end

  def update_height(node)
    node.height = [height(node.left), height(node.right)].max + 1
  end

  def rotate_right(y)
    x = y.left
    t2 = x.right

    x.right = y
    y.left = t2

    update_height(y)
    update_height(x)

    x
  end

  def rotate_left(x)
    y = x.right
    t2 = y.left

    y.left = x
    x.right = t2

    update_height(x)
    update_height(y)

    y
  end

  def insert(key)
    @root = insert_node(@root, key)
  end

  def insert_node(node, key)
    return AVLTreeNode.new(key) if node.nil?

    if key < node.key
      node.left = insert_node(node.left, key)
    elsif key > node.key
      node.right = insert_node(node.right, key)
    else
      return node
    end

    update_height(node)
    balance(node)
  end

  def balance(node)
    balance_factor = self.balance_factor(node)

    if balance_factor > 1
      if self.balance_factor(node.left) >= 0
        return rotate_right(node)
      else
        node.left = rotate_left(node.left)
        return rotate_right(node)
      end
    elsif balance_factor < -1
      if self.balance_factor(node.right) <= 0
        return rotate_left(node)
      else
        node.right = rotate_right(node.right)
        return rotate_left(node)
      end
    end

    node
  end

  def delete(key)
    @root = delete_node(@root, key)
  end

  def delete_node(node, key)
    return node if node.nil?

    if key < node.key
      node.left = delete_node(node.left, key)
    elsif key > node.key
      node.right = delete_node(node.right, key)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      else
        temp = min_value_node(node.right)
        node.key = temp.key
        node.right = delete_node(node.right, temp.key)
      end
    end

    update_height(node)
    balance(node)
  end

  def min_value_node(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def find(key)
    find_node(@root, key)
  end

  def find_node(node, key)
    return nil if node.nil?
    return node if node.key == key

    if key < node.key
      find_node(node.left, key)
    else
      find_node(node.right, key)
    end
  end
end
