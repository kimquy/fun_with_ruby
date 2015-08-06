require 'spec_helper'

describe SaleService do
  let(:orders) {
    [
      [1, "imported box of chocolates", 10.00],
      [1, "imported bottle of perfume", 47.50]
    ]
  }

  subject { described_class.new(orders) }

  describe "#total_before_tax" do
    it 'returns correct value' do
      expect(subject.total_before_tax).to eq(57.5)
    end
  end

  describe "#total_after_tax" do
    it 'returns correct value' do
      expect(subject.total_after_tax).to eq(65.13)
    end
  end

  describe "#sales_taxes" do
    it 'returns correct value' do
      expect(subject.sales_taxes).to eq(7.63)
    end
  end
end