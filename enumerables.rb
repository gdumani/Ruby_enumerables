ars = %w[ab cd ef ij kx]
ari = [10, 20, 30, 40, 50]

def my_each
  return enum_for(__callee__) unless block_given?
  length.times {|i| yield to_a[i]}
end


def my_each_with_index
  return enum_for(__callee__) unless block_given?
  length.times {|i| yield(to_a[i], i)}
end