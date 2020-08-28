require "../enumerables.rb"
test_array1 = [11, 2, 3, 56]
describe Enumerable do
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
end

