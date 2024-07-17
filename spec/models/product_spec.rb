require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: 'cacti')
    @category.save
  end
  describe 'Validations' do
    it 'should not be valid without a name' do  
      product = Product.new(name: nil, price: 2780, quantity: 13, category: @category)
    expect(product).not_to be_valid
    end
    it 'should not be valid without a price' do  
      product = Product.new(name: "Bill", quantity: 13, category: @category)
    expect(product).not_to be_valid
    end
    it 'should not be valid without quantity' do  
      product = Product.new(name: "Bill", price: 2780, quantity: nil, category: @category)
    expect(product).not_to be_valid
    end
    it 'should not be valid without a category' do  
      product = Product.new(name: "Bill", price: 2780, quantity: 13)
    expect(product).not_to be_valid
    end
  end
end
