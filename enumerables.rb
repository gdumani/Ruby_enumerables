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
  self.my_each {|i| res << i if yield(i)}
  return res
end

def my_all
  return enum_for(__callee__) unless block_given?
  self.my_each {|i| return false  if !yield(i)} 
  return true
end
  

public :my_each
public :my_each_with_index
public :my_select
public :my_all




puts ari.my_all {|e| e < 60}
puts ari.my_all {|e| e > 60}