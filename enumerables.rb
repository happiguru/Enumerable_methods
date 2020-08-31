# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    Array(self).length.times do |idx|
      yield(Array(self)[idx])
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    Array(self).length.times do |idx|
      yield(Array(self)[idx], idx)
    end
    self
  end

  def my_select()
    return to_enum(:my_select) unless block_given?

    new_array = []
    Array(self).my_each do |index_value|
      next unless yield(index_value)

      new_array.push(index_value)
    end
    new_array
  end

  def my_all?(arr = nil)
    Array(self).my_each do |item|
      if !block_given?
        if arr.nil?
          next if item
        elsif arr.class == Class
          next if item.is_a? arr
        elsif arr.class == Regexp
          next if item =~ arr
        elsif (item.is_a? Numeric) || (item.is_a? String)
          next if item == arr
        end
      elsif yield(item)
        next
      end
      return false
    end
    true
  end

  def my_any?(arr = nil)
    Array(self).my_each do |arg|
      if !block_given?
        if arr.nil?
          next unless arg
        elsif arr.class == Class
          next unless arg.is_a? arr
        elsif arr.class == Regexp
          next unless arg =~ arr
        elsif (arg.is_a? Numeric) || (arg.is_a? String)
          next unless arg == arr
        end
      else
        next unless yield(arg)
      end
      return true
    end
    false
  end

  def my_none?(arr = nil)
    Array(self).my_each do |arg|
      if !block_given?
        if arr.nil?
          next unless arg
        elsif arr.class == Class
          next unless arg.is_a? arr
        elsif arr.class == Regexp
          next unless arg =~ arr
        elsif (arg.is_a? Numeric) || (arg.is_a? String)
          next unless arg == arr
        end
      else
        next unless yield(arg)
      end
      return false
    end
    true
  end

  def my_count(*args)
    count = 0
    if args.empty?
      if block_given?
        my_each { |i| count += 1 if yield(i) }
      else
        my_each { |_i| count += 1 }
      end
    else
      raise ArgumentError, 'Too many arguments, Expected 1!' if args.length > 1

      puts 'Warning: given block not used' if block_given?
      my_each { |i| count += 1 if i == args[0] }
    end
    count
  end

  def my_map(arr = nil)
    temp_array = []
    if arr.class == Proc
      Array(self).my_each do |arg|
        temp_array.push(arr.call(arg))
      end
      return temp_array
    end
    return to_enum unless block_given?

    Array(self).my_each do |arg|
      temp_array.push(yield(arg))
    end
    temp_array
  end

  def my_inject(*arguments)
    raise LocalJumpError, 'NO BLOCK OR ARGUMENT GIVEN!' if !block_given? && arguments.empty?

    skip_flag = false
    acummulator = Array(self)[0]
    if (arguments[0].class == Symbol) || arguments[0].nil?
      skip_flag = true
    elsif arguments[0].is_a? Numeric
      acummulator = arguments[0]
    end
    Array(self).my_each_with_index do |item, index|
      next if skip_flag && index.zero?

      if block_given?
        acummulator = yield(acummulator, item)
      elsif arguments[0].class == Symbol
        acummulator = acummulator.send(arguments[0], item)
      elsif arguments[0].is_a? Numeric
        acummulator = acummulator.send(arguments[1], item)
      end
    end
    acummulator
  end
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject(:*)
end

# puts [1,2,3].my_count(9, 4)
