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
    Array(self).my_each do |arg|
      if !block_given?
        case arr
        when arr.nil?
          next unless arg
        when arr.class == Class
          next unless arg.is_a? arr
        when arr.class == Regexp
          next unless arg =~ arr
        when (arg.is_a? Numeric) || (arg.is_a? String)
          next unless arg == arr
        end
      else 
        next unless yield(arg)
      end
      return true
    end
    false
  end

  # My None?
  def my_none?(arr = nil)
    Array(self).my_each do |arg|
      if !block_given?
        case arr
        when arr.nil?
          next unless arg
        when arr.class == Class
          next unless arg
        when arr.class == Regexp
          next unless arg =~ arr
        when (arg.is_a? Numeric) || (arg.is_a? String)
          next unless arg == arr
        end
      else
        next unless yield(arg)
      end
      return false
    end
    true
  end

  # My Count
  def my_count(arr = nil)
    counter = 0
    Array(self).my_each do |arg|
      if !block_given?
        return Array(self).length if arg.nil?
        next if arg != arr
        counter += 1
      elsif yield(arg) == true
        counter += 1
      end
    end
    counter
  end

  # My Map
  def my_map(arr = nil)
    temp_array = []
    if arr.class == Proc
      Array(self).my_each do |arg|
        temp_array.push(arr.call(arg))
      end
      temp_array
    end
    return to_enum unless block_given?

    Array(self).my_each do |arg|
      temp_array.push(yield(arg))
    end
    temp_array
  end

  # My Inject
  def my_inject(*arr)
    raise('LocalJumpError.new NO BLOCK OR ARGUMENT GIVEN!') if !block_given? && arguments.empty?

    skip_flag = false
    accumulator = Array(self)[0]
    if (argument[0].class = Symbol) || argument
      while counter < arr.size
        accumulator = yield(accumulator, arr[counter])
        counter += 1
      end
    accumulator
    end
  end

  # Multiply LS
  def multiply_els(arr)
    arr.my_inject(:*)
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

puts 'my_none?'
puts (0..9).my_none?{|n| n < 10}

puts Range.new(0, 9).my_none? {|n| n != 6}

new_harsh = { a: 1, b: 2, c: 3, d: 4, e: 5 }
puts new_harsh.my_none? {|n, y| y == 6}

puts 'my_any?'
puts (0..9).my_any?{|n| n < 10}

puts Range.new(0, 9).my_any? {|n| n != 6}

new_harsh = { a: 1, b: 2, c: 3, d: 4, e: 5 }
puts new_harsh.my_any? {|n, y| y == 6}

puts 'my_count'
puts (0..9).my_count{|n| n < 10}

puts Range.new(0, 9).my_count {|n| n != 6}

new_harsh = { a: 1, b: 2, c: 3, d: 4, e: 5 }
puts new_harsh.my_count {|n, y| y == 6}
