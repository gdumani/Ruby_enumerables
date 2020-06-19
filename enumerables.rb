module Enumerable

  
  def my_each
    return enum_for(__callee__) unless block_given?

    size.times { |i| yield to_a[i] }
    self
  end

  def my_each_with_index
    return enum_for(__callee__) unless block_given?

    size.times { |i| yield(to_a[i], i) }
    self
  end

  def my_select
    return enum_for(__callee__) unless block_given?

    res = []
    my_each { |i| res << i if yield(i) }
    res
  end

  def my_all?(cond)
    if block_given?

    my_each { |i| return false unless yield(i) }

    elsif cond.is_a? Class

      my_each { |i| return false unless i.is_a? cond }
    elsif cond.is_a? Regexp
      
      my_each { |i| return false unless i.match(cond)}
    else
      my_each { |i| return false unless i == cond}
    end
    true
  end

  def my_any?(cond)
    if block_given?

    my_each { |i| return true if yield(i) }
  
    else
      my_each { |i| return true if i.is_a? cond || i == cond}
    end
    false
  end

  def my_none?(cond)
    if block_given?

    my_each { |i| return false if yield(i) }
  
    else
      my_each { |i| return false if i.is_a? cond || i == cond}
    end
    true
  end

  
  def my_count(cond = nil)
    c = 0
    if block_given?

      my_each { |i| c += 1 if yield(i) }
    elsif !cond.nil? 
      my_each { |i| c += 1 if i == cond }
    else
    c = self.size
    end
    c
  end

  def my_map(&oper)
    res = []
    if block_given?
      my_each { |i| res << yield(i) }
    else
      my_each { |i| res << oper.call(i) }
    end
    res
  end

  def my_inject(acumulator = nil, operator = nil)
    if block_given?
      if acumulator.nil?
        acumulator = to_a[0]
        (1...size).my_each { |i| acumulator = yield(acumulator, to_a[i]) }
      else
        my_each { |i| acumulator = yield(acumulator, i) }
      end
    elsif operator.nil?
      operator = acumulator
      acumulator = to_a[0]
      (1...size).my_each { |i| acumulator = acumulator.method(operator).call(to_a[i]) }
    else
      my_each { |i| acumulator = acumulator.method(operator).call(i) }

    end
    acumulator
  end

  def multiply_els
    my_inject(:*)
  end
end


#Test cases second review
array = [4, 1, 4, 4, "5", 3]
block = proc { |num, ind| puts "item #{num} and #{ind}" }
words = %w[dog door rod blade]
puts "pass class type"
p array.all?(Integer)
p array.my_all?(Integer)
puts "pass Regex"
p words.all?(/d/)
p words.my_all?(/d/)
puts "pass argument"
puts "------string"
p words.all?("dog")
p words.my_all?("dog")
puts "--------integer"
p array.all?(4)
p array.my_all?(4)
# p array.my_each_with_index  { |num, ind| puts "item #{num} and #{ind}" }
# puts "-------------------"
# p array.my_each_with_index(&block)
# puts "==================="
# p array.each_with_index  { |num, ind| puts "item #{num} and #{ind}" }
# puts "-------------------"
# p array.each_with_index(&block)

# Test cases to review
# puts (5..10).my_inject {|sum, n| sum + n}
# puts [1,2,4,2].my_count(2)

# puts %w[ant bear cat].my_all? {|word| word.length >= 3}
# puts %w[ant bear cat].my_none? {|word| word.length == 5}
# puts %w[ant bear cat].my_any? {|word| word.length >= 5}



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
