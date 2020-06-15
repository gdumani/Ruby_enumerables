arr = [0,1,2,3,4,5]

def my_each
  return enum_for(__callee__)
end



arr.my_each
