arr = [0,1,2,3,4,5]
has= {"One" => 1,"Two" => 2,"Three" => 3}

def my_each
  return enum_for(__callee__) unless block_given?
  length.times {|i| yield to_a[i]}
end

def my_each_with_index
  return enum_for(__callee__) unless block_given?
  length.times {|i| yield to_a[i]}
end

arr.my_each_with_index
