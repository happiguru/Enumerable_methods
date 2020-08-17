module Enumerable

  # My Each Method

  def my_each
    return to_enum(:my_each) unless block_given?
    arr = self.class == Array ? self : to_a
    counter = 0
    while counter <arr.length
      yield(arr[counter])
      counter += 1
    end
    arr
  end

  # My Each With Index

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
      yield(arr[counter], counter)
      counter += 1
    end
    arr
  end

  # My Select

  def my_select
    return to_enum(:my_each_with_index) unless block_given?
    new_array = []
    my_each() {|index_value| new_array << index_value if yield(index_value)}
    puts new_array
  end

  # My All?

  def my_all?
    result = nil
    self.my_each do | item |
      if yield(item)
        result = true
      else
        result = false
    end
    result
  end

  # My Any?

  def my_any?
    result = false
    self.my_each do | item |
      next unless yield(item)
        result = true
      end
      result
    end
    result
  end

  # My None?

  def my_none?
    result = false
    self.my_each do | item |
      if yield(item)
        result = false
      else
        result = true
      end
      result
    end
    result
  end

  # My Count

  def my_count
    yield
  end

  # My Map 

  def my_map
    yield
  end

  # My Inject

  def my_inject
    yield
  end

  # Multiply LS

  def multiply_ls
    yield
  end

  puts 'my_each Array'
  [1, 2, 34, 44, 54].my_each do |n|
    puts n 
    end

  puts 'my_each_with_index Array'
  [55, 6, 89, 74, 57].my_each_with_index do |n, i|
    puts i.to_s + ' : ' + n.to_s
    end

  puts 'my_select'
  [8, 5, 69, 10, 7].my_select do |n|
    n>6
  end
end