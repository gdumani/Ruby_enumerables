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
  res=[]

  self.my_each do |i|

    if yield(i)
     res << i
    end
  end

  return res
end

public :my_each
public :my_each_with_index
public :my_select




puts ari.my_select {|element| element > 20}
