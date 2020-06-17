def my_each
  return enum_for(__callee__) unless block_given?
  size.times {|i| yield to_a[i]}
end


def my_each_with_index
  return enum_for(__callee__) unless block_given?
  length.times {|i| yield(to_a[i], i)}
end

def my_select
  return enum_for(__callee__) unless block_given?
  res=[]
  my_each {|i| res << i if yield(i)}
  return res
end

def my_all
  return enum_for(__callee__) unless block_given?
  self.my_each {|i| return false  if !yield(i)}
  return true
end

def my_any
  return enum_for(__callee__) unless block_given?
  self.my_each {|i| return true  if yield(i)}
  return false
end

def my_none
  return enum_for(__callee__) unless block_given?
  self.my_each {|i| return false  if yield(i)}
  return true
end

def my_count
  return enum_for(__callee__) unless block_given?
  c=0
  self.my_each {|i| c+=1 if yield(i)}
  return c
end

def my_map (&op)
    res=[]
  if block_given?  
    self.my_each {|i| res << yield(i)}
  else
    self.my_each {|i| res << op.call(i)}
  end
  return res
end

def my_inject(c=nil, op=nil)
  if block_given?
    if c.nil?
      c=to_a[0]
      (1...self.length).my_each {|i| c=yield(c,self.to_a[i])}    
    else
      self.my_each {|i| c=yield(c,i)}
    end
  else
    op, c = c, nil if op.nil?
    if c.nil?
      c=to_a[0]
      (1...self.length).my_each { |i| c = c.method(op).call(self.to_a[i]) }
    else
      self.my_each { |i| c = c.method(op).call(i)}
    end
  end
  return c
end

def multiply_els
  self.my_inject(:*)
end

public :my_each
public :my_each_with_index
public :my_select
public :my_all
public :my_any
public :my_none
public :my_count
public :my_map
public :my_inject
public :multiply_els

# #------test data-------
# ars = %w[ab cd ef ij kx]
# ari = [10, 20, 30, 40, 50]



# puts "----my_map with proc:"
# puts ars.my_map(&:upcase)
# puts "----my_map with block:"
# puts ars.my_map {|s| s.upcase}

# puts "------------------------"
# puts "----my_inject with hash"
# array = [['A', 'a'], ['B', 'b'], ['C', 'c']]
# hash = array.my_inject({}) do |memo, values|
#  memo[values.first] = values.last
#  memo
# end
# puts hash

# puts "----inject with single proc"
# puts ari.inject(:+)
# puts "----inject with initial and proc"
# puts ari.inject(5,:+)
# puts "----------------------------------"
# puts "----my_inject with single proc"
# puts ari.my_inject(:+)
# puts "----my inject with initial and proc"
# puts ari.my_inject(5,:+)
# puts '===================================='

# puts "----inject with single proc"
# puts ari.inject(:-)
# puts "----inject with initial and proc"
# puts ari.inject(5,:-)
# puts "----------------------------------"
# puts "----my_inject with single proc"
# puts ari.my_inject(:-)
# puts "----my inject with initial and proc"
# puts ari.my_inject(5,:-)
# puts '===================================='

# puts "----inject with single proc"
# puts ari.inject(:*)
# puts "----inject with initial and proc"
# puts ari.inject(5,:*)
# puts "----------------------------------"
# puts "----my_inject with single proc"
# puts ari.my_inject(:*)
# puts "----my inject with initial and proc"
# puts ari.my_inject(5,:*)
# puts '===================================='

# puts "----inject with block"
# puts ari.inject {|sum, number| sum * number}
# puts "----inject with initial value and block"
# puts ari.inject (5) {|sum, number| sum * number}
# puts "=============================="
# puts "----my_inject with block"
# puts ari.my_inject {|sum, number| sum * number}
# puts "----my_inject with initial value and block"
# puts ari.my_inject (5) {|sum, number| sum * number}

# puts "----------------------------"
# puts "----multipy_els"
# puts ari.multiply_els
# puts "----------------------------"
# puts "----my_count {|e| e > 20}"
# puts ari.my_count {|e| e > 20}
# puts "-----------------------------"
# puts "---- my_none =60"
# puts ari.my_none {|e| e == 60}
# puts "---- my none >60"
# puts ari.my_none {|e| e > 60}
