require './sale_service'

INPUTS = CSV.read("assets/input.csv")

# 1, book, 12.49
# 1, music cd, 14.99
# 1, chocolate bar, 0.85
INPUT1 = [INPUTS[1], INPUTS[2], INPUTS[3]]

# 1, imported box of chocolates, 10.00
# 1, imported bottle of perfume, 47.50
INPUT2 = [INPUTS[4], INPUTS[5]]

# 1, imported bottle of perfume, 27.99
# 1, bottle of perfume, 18.99
# 1, packet of headache pills, 9.75
# 1, box of imported chocolates, 11.25
INPUT3 = [INPUTS[6], INPUTS[7], INPUTS[8], INPUTS[9]]

sale_service = SaleService.new(INPUT3)

sale_service.output_to_csv


