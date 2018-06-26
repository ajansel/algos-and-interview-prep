require_relative "00_static_array"

# You must not build any normal Ruby Arrays; use only your StaticArray.
# This shows how to build the DynamicArray from a StaticArray, which
# is more like what you have in the C programming language. In this way
# you repeat what the authors of Ruby have done for you with the Ruby
# Array class.
class DynamicArray
  attr_reader :length

  # You will likely need two instance variables:
  # 1. @store
  # 2. @length: "logical" number of items currently stored in the
  #    store. Not simply the "capacity" of the store.
  #
  # BTW: check out the protected methods and attr declarations.
  def initialize
    @store = StaticArray.new(8)
    @length = 0
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    # Don't worry about resizing until the end of the specs. Assume
    # capacity is sufficient at first.
    @length += 1
    self[length - 1] = val
    val
  end
  
  # O(1)
  def [](index)
    raise "DynamicArray: index out of bounds" if index > length - 1 || index < 0
    @store[index]
  end
  
  # O(1)
  def pop
    # No "shrinking" is required nor typical.
    raise "DynamicArray: index out of bounds" if @length == 0
    value = self[length - 1]
    @length -= 1
    value
  end
  
  # O(1)
  def []=(index, value)
    raise "DynamicArray: index out of bounds" if index > length - 1 || index < 0
    @store[index] = value
  end

  # O(n): has to shift over all the elements. (Hint: when shifting over
  # don't mistakenly overwrite the next value to shift over.)
  def unshift(val)
    # Don't worry about resizing until the end. Assume
    # capacity is sufficient at first.
    @length += 1
    prev_length = @length - 1
    prev_length.downto(1) do |idx|
      self[idx] = self[idx - 1]
    end 
    self[0] = val
    val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "DynamicArray: index out of bounds" if @length == 0
    shifted_val = self[0]
    # 0  length - 2
    (length - 1).times do |idx|
      self[idx] = self[idx + 1]
    end 
    @length -= 1
    shifted_val
  end

  protected
  attr_accessor :store
  attr_writer :length

  # Capacity of number of items the store can store at maximum.
  # Need so you know when to resize.
  def capacity
    @store.length
  end

  # Why can't we simply rely on StaticArray's checking of indices?
  def check_index(index)
  end

  # Double the size of the store when pushing or unshifting and it
  # would otherwise cause length > capacity. O(n): has to copy over all
  # the elements to the new store.
  def resize!
  end
end
