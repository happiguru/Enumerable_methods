module Enumerable

  # My Each Method

  def my_each(arr)

    for item in arr do
      yield item
    end 

  end

  my_arr = [1, 2, 34, 54, 54]

  puts my_each(my_arr) { item * 2 }

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

end