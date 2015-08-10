require 'spec_helper'
require 'pry'

describe SaleService do
  let(:orders1) {
    [
      [1, "imported box of chocolates", 10.00],
      [1, "imported bottle of perfume", 47.50]
    ]
  }

  let(:orders2) {
    [
      [1, "book", 12.49],
      [1, "music cd", 14.99],
      [1, "chocolate bar", 0.85]
    ]
  }

  let(:orders3) {
    [
      [1, "imported bottle of perfume", 27.99],
      [1, "bottle of perfume", 18.99],
      [1, "packet of headache pills", 9.75],
      [1, "box of imported chocolates", 11.25]
    ]
  }

  let(:sale_service1) { described_class.new(orders1) }
  let(:sale_service2) { described_class.new(orders2) }
  let(:sale_service3) { described_class.new(orders3) }

  describe "#total_before_tax" do
    it 'returns correct value' do
      expect(sale_service1.total_before_tax).to eq(57.5)
      expect(sale_service2.total_before_tax).to eq(28.33)
      expect(sale_service3.total_before_tax).to eq(67.98)
    end
  end

  describe "#total_after_tax" do
    it 'returns correct value' do
      expect(sale_service1.total_after_tax).to eq(65.15)
      expect(sale_service2.total_after_tax).to eq(29.83)
      expect(sale_service3.total_after_tax).to eq(74.68)
    end
  end

  describe "#sales_taxes" do
    it 'returns correct value' do
      expect(sale_service1.sales_taxes).to eq(7.65)
      expect(sale_service2.sales_taxes).to eq(1.5)
      expect(sale_service3.sales_taxes).to eq(6.70)
    end
  end
end
