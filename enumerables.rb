module Enumerable
  # My Each Method
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
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
    new_array = []
    my_each{ |index_value| new_array << index_value if yield(index_value) }
      puts new_array
    end
  end

  # My All?
  def my_all?
    result = nil
    my_each do |item|
      if yield(item == true)
        result = true
      else
        result = false
      end
    result
  end

  # My Any?
  def my_any?

    result = false
    my_each do |item|
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
    my_each do |item|
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
    counter = 0
    my_each do |item| if yield(item)
      counter += 1
    end
    counter
  end

  # My Map 
  def my_map(&block_given)
    result = []
    my_each do |element|
      result << block_given.call(element)
    end
    result
  end

  # My Inject
  def my_inject(start_value = 0)
    counter = 0
    accumulator = start_value
    while counter < self.size
      accumulator =  yield(accumulator, self[counter])
      counter += 1
    end
    accumulator
  end

  # Multiply LS
  def multiply_els
    self.my_inject(1){ |a, b|a * b  }
  end
end
