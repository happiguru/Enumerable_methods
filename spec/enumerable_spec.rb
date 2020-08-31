require_relative '../enumerables.rb'

describe Enumerable do
  test_array1 = [11, 2, 3, 56]
  let(:arr_1) { %w[ant bear cat] }
  let(:range) { (5..10) }
  let(:ary) { [1, 2, 9, 7, 11, 23, 8] }
  describe '#my_each' do
    it 'returns the input array' do
      expect(test_array1.my_each { |x| x }).to eql(test_array1)
    end
  end

  describe '#my_each_with_index' do
    it 'returns the array and it index' do
      expect(test_array1.my_each_with_index { |x, y| }).to eql(test_array1)
    end
  end

  describe '#my_select' do
    it 'returns filtered array based on supplied block' do
      expect((0...10).my_select { |i| (i % 3) == 0 }).to eql([0, 3, 6, 9])
    end
  end

  describe '#my_all' do
    it 'returns true if all array items satisfy condition in block' do
      expect(arr_1.my_all? { |word| word.length >= 3 }).to be_truthy
    end
    it 'returns false if some of the array items do not satisfy condition in block' do
      expect(arr_1.my_all? { |word| word.length >= 4 }).to be_falsy
    end
    it 'returns true if all array items match regex argument' do
      expect(arr_1.my_all?(/a/)).to be_truthy
    end
    it "returns false if some array items don't match regex argument" do
      expect(arr_1.my_all?(/t/)).to be_falsy
    end
    it "returns false if all array items don't match regex argument" do
      expect(arr_1.my_all?(/z/)).to be_falsy
    end
    it 'returns true if all array items are of the class in argument' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
    end
    it 'returns false if some array items are not of the class in argument' do
      expect(['a', 2i, 3.14].my_all?(Numeric)).to be_falsy
    end
    it 'returns false if some array items are not equal to the argument' do
      expect([1, 2].my_all?(1)).to be_falsy
    end
  end

  describe '#my_any' do
    it 'returns true if any of the item in the array satisfy the condition in the block' do
      expect(arr_1.my_any? { |word| word.length >= 3 }).to be_truthy
    end
    it 'returns false if none of the item in the array satisfy the condition in the block' do
      expect(arr_1.my_any? { |word| word.length >= 5 }).to be_falsy
    end
    it 'returns false if none of the items matches the regex arguments' do
      expect(arr_1.my_any?(/x/)).to be_falsy
    end

    it 'returns true if any of the items matches the regex arguments' do
      expect(%w[ant bear catx].my_any?(/x/)).to be_truthy
    end

    it 'returns true if any of the items is the class in the argument' do
      expect([nil, true, 99].my_any?(Integer)).to be_truthy
    end

    it 'returns false if none of the items is the class in the argument' do
      expect([nil, true, 'hello'].my_any?(Integer)).to be_falsy
    end

    it 'returns true if any of the items is equal to the argument' do
      expect([1, 1].my_any?(1)).to be_truthy
    end

    it 'returns false if none of the items is equal to the argument' do
      expect([1, 1].my_any?(2)).to be_falsy
    end
  end

  describe '#my_none' do
    it 'returns true if none of the item in the array satisfy the condition in the block' do
      expect(arr_1.my_none? { |word| word.length == 5 }).to be_truthy
    end
    it 'returns false if any of the item in the array satisfy the condition in the block' do
      expect(arr_1.my_none? { |word| word.length == 4 }).to be_falsy
    end
    it 'returns true if none of the items matches the regex arguments' do
      expect(arr_1.my_none?(/x/)).to be_truthy
    end
    it 'returns false if any of the items matches the regex arguments' do
      expect(arr_1.my_none?(/a/)).to be_falsy
    end
    it 'returns true if none of the items is the class in the argument' do
      expect([nil, true, 'a'].my_none?(Integer)).to be_truthy
    end
    it 'returns false if any of the items is the class in the argument' do
      expect([nil, true, 99].my_none?(Integer)).to be_falsy
    end
    it 'returns true if none of the items is equal to the argument' do
      expect([1, 1].my_none?(2)).to be_truthy
    end
    it 'returns false if any of the items is equal to the argument' do
      expect([1, 1].my_none?(1)).to be_falsy
    end
  end

  describe '#my_count' do
    it 'returns the number of items in an array if there is no argument given' do
      expect(ary.my_count).to eql(7)
    end
    # refactor method
    it 'returns the number of items in an array that are equal to the argument given' do
      expect(ary.my_count(9)).to eql(1)
    end

    it 'returns the number of items in an array that satisfy the condition in the argument given' do
      expect(ary.my_count(&:even?)).to eql(2)
    end

    it 'returns the number of items that satisfy the condition in the block given' do
      expect(arr_1.my_count { |i| i.is_a? String }).to eql(3)
    end

    it 'returns the number of items in a range given' do
      expect((1..10).my_count).to eql(10)
    end

    it 'raises an error if more than one argument is supplied' do
      expect { ary.my_count(9, 4) }.to raise_error(ArgumentError, 'Too many arguments, Expected 1!')
    end
  end

  describe '#my_map' do
    my_proc = proc { |x| x * x }
    it 'returns a new array after invoking the block once for each element' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'returns the block value for each item if the block contains only a single value' do
      expect((1..4).my_map { 'cat' }).to eql(%w[cat cat cat cat])
    end

    it 'returns a new array after invoking the proc once for each element' do
      expect([1, 2, 7, 4, 5].my_map(my_proc)).to eql([1, 4, 49, 16, 25])
    end
  end

  describe '#my_inject' do
    it 'returns a combination of the elements by applying a binary operation, specified by a block with argument' do
      expect(range.my_inject(2) { |sum, n| sum + n }).to eql(47)
    end

    it 'returns a combination of the elements by applying a binary operation, specified by a block without argument' do
      expect(range.my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'returns a combination of all the elements of the enum by applying a binary operation, specified by a symbol' do
      expect(range.my_inject(2, :*)).to eql(302_400)
    end

    it 'raise an error when no block or argument is given' do
      expect { range.my_inject }.to raise_error(LocalJumpError, 'NO BLOCK OR ARGUMENT GIVEN!')
    end
  end

  describe '#multiply_els' do
    arr = [2, 4, 5]
    it 'returns the product of all the elements given in the array passed to the method' do
      expect(multiply_els(arr)).to eql(40)
    end
  end
end
