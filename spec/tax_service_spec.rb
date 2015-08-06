require 'spec_helper'

describe TaxService do
  let(:line_item1) {
    {
      quantity: 1,
      name: 'imported box of chocolates',
      price: '10.00'
    }
  }

  let(:line_item2) {
    {
      quantity: 1,
      name: 'imported bottle of perfume',
      price: '47.50'
    }
  }

  let(:tax_service1) { described_class.new(line_item1) }
  let(:tax_service2) { described_class.new(line_item2) }

  describe "#tax_rate" do
    context 'imported food' do
      it 'applies 5% tax rate' do
        expect(tax_service1.tax_rate).to eq(0.05)
      end
    end

    context 'imported perfume' do
      it 'applies 15% tax rate' do
        expect(tax_service2.tax_rate).to eq(0.15)
      end
    end
  end

  describe "#applied_tax_amount" do
    it 'returns correct values' do
      expect(tax_service1.applied_tax_amount).to eq(0.5)
      expect(tax_service2.applied_tax_amount).to eq(7.13)
    end
  end

  describe "#price_after_tax" do
    it 'returns correct values' do
      expect(tax_service1.price_after_tax).to eq(10.5)
      expect(tax_service2.price_after_tax).to eq(54.63)
    end
  end
end