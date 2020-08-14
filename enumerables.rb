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
    yield
  end

  # My Select

  def my_select
    yield
  end

  # My All?

  def my_all?
    yield
  end

  # My Any?

  def my_any?
    yield
  end

  # My None?

  def my_none?
    yield
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
end