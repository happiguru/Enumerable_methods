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

    
end

