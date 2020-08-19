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

  def my_all?(argument = nil)
    Array(self).my_each do |item|
      if !block_given?
        case argument
        when argument.nil?
          next if item
        when argument.class == Class
          next if item.is_a? argument
        when argument.class == regexp
          next if item =~ argument
        when (item.is_a? Numeric) || (item.is_a? String)
          next if item == argument
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
    # raise('LocalJumpError.new NO BLOCK OR ARGUMENT GIVEN!') if !block_given? && arguments.empty?

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
        acummulator = yield(acum, item)
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
