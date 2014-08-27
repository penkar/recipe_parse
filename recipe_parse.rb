class Recipe
  attr_reader :name, :servings, :ingredients, :list
 @@list = []
  def initialize(name, servings)
    @name = name
    @servings = servings
    @ingredients = []
    @@list << self
  end
 
  def add_ingredient(i)
    @ingredients << i
  end

  	def self.list
		@@list.each do |x| 
			puts x.name+' '+ x.servings
			x.ingredients.each {|y| puts '    ' + y.name + ' ' + y.quantity.to_s+ ' '+ y.units}
			end
	end
 
end
 
class Ingredient
  attr_reader :name, :quantity, :units
 
  def initialize(name, quantity=:to_taste, units='')
    @name = name
    @quantity = quantity
    @units = units
  end
end

raw = File.read('recipes.txt')
step1 = raw.split("\n\n")
step2 = step1.map { |x| x.split("\n") }


step2.each do |recipe|
	xnew = Recipe.new(recipe[0],recipe[1][-1])
	recipe[2..-1].each do |x|
		measurements = ['oz','tbs','lbs','cup']
		if x[0].match(/\d/)
			amt = x.split[0].to_i
				if measurements.include?(x.split[1])
					unit = x.split[1]
					ing = x.split[2..-1].join(' ')
					xnew.add_ingredient(Ingredient.new(ing,amt,unit))
				else
					ing = x.split[1..-1].join(' ')
					xnew.add_ingredient(Ingredient.new(ing,amt))
				end
			
		else
			xnew.add_ingredient(Ingredient.new(x))		
		end
	end
end
puts Recipe.list



# raw = File.read('recipes.txt')
# step1 = raw.split("\n\n")
# step2 = step1.map { |x| x.split("\n") }
# y = step2.map do |rec|
#   {
#     name: rec[0],
#     serves: rec[1].split.last.to_i,
#     ingredients: rec[2..-1]
#   }
# end
# p step2
# puts


