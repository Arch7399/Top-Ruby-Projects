def sort_this(arr)
    arr.each_cons(2) do |num1, num2|
      if num1 > num2
        arr[arr.index(num1)] = num2
        arr[arr.index(num2)] = num1
      end
    end
    arr
  end
  
  A = [1,9,2,8,3,7,4,6,5]
  p sort_this(A)
  