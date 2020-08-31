require "../enumerables.rb"

describe Enumerable do
  test_array1 = [11, 2, 3, 56]
    describe "#my_each" do
        it "returns the input array" do
            expect(test_array1.my_each { |x| print x }).to eql(test_array1)
        end
    end

    describe "#my_each_with_index" do
        it "returns the array and it index" do
            expect(test_array1.my_each_with_index { |x, y| }).to eql(test_array1)
        end
    end

    describe "#my_select" do
      it "returns filtered array based on supplied block" do
        expect((0...10).my_select { |i| (i % 3) == 0 }).to eql([0, 3, 6, 9])
      end
    end

    describe "#my_all" do
      it "returns true if all array items satisfy condition in block" do
        expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
      end
      it "returns false if some of the array items do not satisfy condition in block" do
        expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
      end
      it "returns true if all array items match regex argument" do
        expect(%w[ant bear cat].my_all?(/a/)).to eql(true)
      end
      it "returns false if some array items don't match regex argument" do
        expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
      end
      it "returns false if all array items don't match regex argument" do
        expect(%w[ant bear cat].my_all?(/z/)).to eql(false)
      end
      it "returns true if all array items are of the class in argument" do
        expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
      end
      it "returns false if some array items are not of the class in argument" do
        expect(["a", 2i, 3.14].my_all?(Numeric)).to eql(false)
      end
      it "returns false if some array items are not equal to the argument" do
        expect([1, 2].my_all?(1)).to eql(false)
      end
    end

    describe "#my_any" do
      it "returns true if any of the item in the array satisfy the condition in the block" do
        expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
      end
      it "returns false if none of the item in the array satisfy the condition in the block" do
        expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to eql(false)
      end
      it "returns false if none of the items matches the regex arguments" do
        expect(%w[ant bear cat].my_any?(/x/)).to eql(false) 
      end

      it "returns true if any of the items matches the regex arguments" do
        expect(%w[ant bear catx].my_any?(/x/)).to eql(true) 
      end

      it "returns true if any of the items is the class in the argument" do
        expect([nil, true, 99].my_any?(Integer)).to eql(true) 
      end

      it "returns false if none of the items is the class in the argument" do
        expect([nil, true, "hello"].my_any?(Integer)).to eql(false) 
      end

      it "returns true if any of the items is equal to the argument" do
        expect([1, 1].my_any?(1)).to eql(true) 
      end

      it "returns false if none of the items is equal to the argument" do
        expect([1, 1].my_any?(2)).to eql(false) 
      end
    end

    describe "#my_none" do
      it "returns true if none of the item in the array satisfy the condition in the block" do
        expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
      end
      it "returns false if any of the item in the array satisfy the condition in the block" do
        expect(%w[ant bear cat].my_none? { |word| word.length == 4 }).to eql(false)
      end
      it "returns true if none of the items matches the regex arguments" do
        expect(%w[ant bear cat].my_none?(/x/)).to eql(true) 
      end
      it "returns false if any of the items matches the regex arguments" do
        expect(%w[ant bear cat].my_none?(/a/)).to eql(false) 
      end
      it "returns true if none of the items is the class in the argument" do
        expect([nil, true, "a"].my_none?(Integer)).to eql(true) 
      end
      it "returns false if any of the items is the class in the argument" do
        expect([nil, true, 99].my_none?(Integer)).to eql(false) 
      end
      it "returns true if none of the items is equal to the argument" do
        expect([1, 1].my_none?(2)).to eql(true) 
      end
      it "returns false if any of the items is equal to the argument" do
        expect([1, 1].my_none?(1)).to eql(false) 
      end
    end

    describe "#my_count" do
      ary = [1, 2, 9, 7, 11, 23, 8]

      it "returns the number of items in an array if there is no argument given" do
        expect(ary.my_count).to eql(7)
      end
      # refactor method
      it "returns the number of items in an array that are equal to the argument given" do
        expect(ary.my_count(9)).to eql(1)
      end

      it "returns the number of items in an array that satisfy the condition in the argument given" do
        expect(ary.my_count(&:even?)).to eql(2)
      end

      it "returns the number of items that satisfy the condition in the block given" do
        expect(%w[ant bear cat].my_count { |i| i.is_a? String } ).to eql(3)
      end

      it "returns the number of items in a range given" do
        expect((1..10).my_count).to eql(10)
      end
    end

    describe "#my_map" do
      my_proc = proc { |x| x * x }
      it "returns a new array after invoking the block once for each element" do
        expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
      end

      it "returns the block value for each item if the block contains only a single value" do
        expect((1..4).my_map { "cat"}).to eql(%w[cat cat cat cat])
      end

      it "returns a new array after invoking the proc once for each element" do
        expect([1, 2, 7, 4, 5].my_map(my_proc)).to eql([1, 4, 49, 16, 25])
      end

    end
    
end
