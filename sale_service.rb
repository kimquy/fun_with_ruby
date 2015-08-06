require './tax_service'
require 'csv'

class SaleService
  attr_accessor :orders, :line_items, :after_tax_line_items
  def initialize(orders)
    @orders     = orders
    @line_items = []
    @after_tax_line_items = []
    line_items_builder
    after_tax_line_items_builder
  end

  def sales_taxes
    (total_after_tax - total_before_tax).round(2)
  end

  def total_before_tax
    @line_items.map{|item| item[:price] }.reduce(:+).round(2)
  end

  def total_after_tax
    @after_tax_line_items.map{|item| item[:price] }.reduce(:+).round(2)
  end

  def output_to_csv
    CSV.open("./ouput.csv", "wb") do |csv|
      csv << ["Quantity", "Name", "Price"]

      @after_tax_line_items.each do |item|
        csv << [item[:quantity], item[:name], item[:price]]
      end
    end
  end

  private
  # Populate line_items from input into a hash
  def line_items_builder
    @orders.each do |item|
      @line_items << {
        quantity: item[0],
        name:     item[1],
        price:    item[2]
      }
    end
  end

  def after_tax_line_items_builder
    @line_items.each do |item|
      @after_tax_line_items << {
        quantity: item[:quantity],
        name:     item[:name],
        price:    TaxService.new(item).price_after_tax
      }
    end
  end

end