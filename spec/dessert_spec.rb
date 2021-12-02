require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", :name => "bob dole", :titleize => "Chef Bob Dole the Great Baker") }
  subject(:dessert) { Dessert.new("cake", 100, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{ Dessert.new("cake", "100", "cheffy") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("milk")
      expect(dessert.ingredients).to include("milk")
    end
  end

  describe "#mix!" do
    before(:each) do
      dessert.add_ingredient("milk")
      dessert.add_ingredient("flour")
      dessert.add_ingredient("eggs")
      dessert.add_ingredient("butter")
    end
    let(:ingredients) { ["milk","flour","eggs","butter"] }

    it "shuffles the ingredient array" do
      dessert.mix!
      expect(dessert.ingredients).to_not eq(ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(50)
      expect(dessert.quantity).to eq(50)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(200) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to include("Bob Dole")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
