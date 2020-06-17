ars = %w[ab cd ef ij kx]
ari = [10, 20, 30, 40, 50]

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
    # puts "block"
    self.my_each {|i| c=yield(c,i)}
    return c
  else
    # puts "noblock"
    if op.nil?
      op=c
      op==:+||op==:- ? c=0 : c=1
    end
    self.my_each { |i| c = c.method(op).call(i) }
    return c
  end
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

puts "op:"
puts ars.my_map(&:upcase)
puts "block:"
puts ars.my_map {|s| s.upcase}
##array = [['A', 'a'], ['B', 'b'], ['C', 'c']]
##hash = array.my_inject({}) do |memo, values|
#  memo[values.first] = values.last
#  memo
#end

#puts hash
# puts ari.multiply_els

#puts ari.inject(:-)


#puts ari.my_inject {|sum, number| sum + number}

#puts ars.my_map {|s| s.upcase}

# puts ari.my_count {|e| e > 20}

#puts "60"
#puts ari.my_none {|e| e == 60}
#puts ">60"
#puts ari.my_none {|e| e > 60}
