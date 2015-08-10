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
  # If raw result with the secend decimal place <= 5 then round it up to 0.05
  # else then roud it up to upper bound
  # Example: 0.5612 => 0.6
  # Example: 7.125  => 7.15
  def applied_tax_amount
    _raw_result = total * tax_rate
    if _raw_result.to_s[3].to_i <= 5
      (_raw_result * 20).round / 20.0
    else
      (_raw_result * 10).round / 10.0
    end
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
    elsif !product_imported? && !product_tax_exempted?
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
