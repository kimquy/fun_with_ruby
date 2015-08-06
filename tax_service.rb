class TaxService
  EXEMPT_PRODUCT_TYPE = %w(book chocolate pills)
  IMPORTED_PRODUCT    = 'imported'

  attr_accessor :product, :quantity, :price

  def initialize(line_item= {})
    @product  = line_item.fetch(:name)
    @quantity = line_item.fetch(:quantity).to_i
    @price    = line_item.fetch(:price).to_f
  end

  # Return the tax amount
  def applied_tax_amount
    (total * tax_rate).round(2)
  end

  # Total price after tax
  def price_after_tax
    (total + applied_tax_amount).round(2)
  end

  def total
    @quantity * @price
  end

  # Return tax rate for a type of product
  def tax_rate
    if product_imported? && !product_tax_exempted?
      0.15
    elsif product_imported? && product_tax_exempted?
      0.05
    elsif !product_imported? && product_tax_exempted?
      0.1
    else
      0.0
    end
  end

  private

  def product_imported?
    product.include?(IMPORTED_PRODUCT)
  end

  def product_tax_exempted?
    EXEMPT_PRODUCT_TYPE.each do |type|
      return true if @product.include?(type)
    end
    false
  end
end