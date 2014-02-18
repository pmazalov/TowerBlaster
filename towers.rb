class Block

	attr_accessor :value, :smaller_than_bottom
	def initialize(value)
		@value              = value
		@smaller_than_bottom = :unknown
	end
	
end

class Tower

	attr_reader :height, :max_value, :is_complete
	def initialize(height, block_max_value)
		@height      = height
		@max_value   = block_max_value
		@is_complete = false
		@tower = []

		generate_tower
	end
	
	def is_valid_value(value)
		value <= max_value
	end

	def generate_tower
		buffer = (1..max_value).to_a.shuffle[0,height]
		buffer.each { |i| @tower << Block.new(i) }
		adjust_block_relation
	end

	def is_finished
		is_complete = @tower.all? {|i| i.smaller_than_bottom == true}
	end

	def generate_block
		buffer = []
		while buffer.size != 1
			number = rand(1..max_value)
			buffer << number unless @tower.any? {|i| i.value == number }
		end
		Block.new(buffer [0])
	end

	def swap_at(coordinate, block)
		@tower[coordinate] = block
		adjust_block_relation
	end

	def adjust_block_relation
		0.upto(height - 2).each do |i|
			if @tower[i].value < @tower[i + 1].value
			  @tower[i].smaller_than_bottom = true
			else
				@tower[i].smaller_than_bottom = false
			end
		end
		@tower.last.smaller_than_bottom = true
	end


end

# p asd = Tower.new(10, 50)
#  p asd.is_finished
# p  block = asd.generate_block
# asd.swap_at(2,block)
# p asd