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
