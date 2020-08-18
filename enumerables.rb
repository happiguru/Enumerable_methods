module Enumerable
  # My Each Method
  def my_each
    return to_enum(:my_each) unless block_given?

    Array(self).length.times do |idx|
      yield(Array(self)[idx])
    end
    self
  end

  # My Each With Index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    Array(self).length.times do |idx|
      yield(Array(self)[idx], idx)
    end
    self
  end

  # My Select
  def my_select()
    return to_enum(:my_select) unless block_given?

    new_array = []
    Array(self).my_each do |index_value|
      next unless yield(index_value)
      new_array.push(index_value)
    end
    new_array
  end

  # My All?
  def my_all?(argument = nil)
    Array(self).my_each do |item|
    
      if !block_given?
      
        case argument
        
          when argument.nil?
            next if item
          when argument.class==Class
            next if item.is_a? argument
          when argument.class == regexp
            next if item =~ argument
          when (item.is_a?Numeric) || (item.is_a? String)
            next if item == argument
        end
      elsif yield(item)
        next
      end
      return false
    end
    true
  end

  # My Any?
  def my_any?(arr = nil)
    result = false
    arr.my_each do |item|
      next unless yield(item)

      result = true
    end
    result
  end

  # My None?
  def my_none?(arr)
    result = true
    arr.my_each do |item|
      result = false if yield(item)
    end
    result
  end

  # My Count
  def my_count(arr = nil)
    counter = 0
    arr.my_each do |item|
      counter += 1 if yield(item)
    end
    counter
  end

  # My Map
  def my_map(arr = nil, &block_given)
    return to_enum(:my_each) unless block_given?

    result = []
    arr.my_each do |element|
      result << block_given.call(element)
    end
    result
  end

  # My Inject
  def my_inject(arr, start_value = 0)
    counter = 0
    accumulator = start_value
    while counter < arr.size
      accumulator = yield(accumulator, arr[counter])
      counter += 1
    end
    accumulator
  end

  # Multiply LS
  def multiply_els(arr)
    arr.my_inject(arr, 1) { |a, b| a * b }
  end
end

puts 'my_each'
(0..9).my_each do |n|
  puts n
end

Range.new(0, 9).my_each do |n|
  puts n
end

puts 'my_each_with_index'
(0..9).my_each_with_index do |n, i|
  puts i.to_s + ' : ' + n.to_s
end

Range.new(0, 9).my_each_with_index do |n, i|
    puts i.to_s + ' : ' + n.to_s
end

puts 'my_select'
puts (0..9).my_select { |n| n < 6 }

puts Range.new(0, 9).my_select { |n| n > 6 }

puts 'my_all?'
puts (0..9).my_all?{|n| n < 10}

puts Range.new(0, 9).my_all? {|n| n != 6}

new_harsh = { a: 1, b: 2, c: 3, d: 4, e: 5 }
puts new_harsh.my_all? {|n, y| y == 6}
