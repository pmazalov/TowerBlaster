require_relative "towers.rb"
require_relative "ai.rb"

class Cli
	def run
		@exit = false
		until @exit
			puts "Insert blocks count and max value!"
			start_game gets
		end

		until @player_tower.is_finished or @Ai.ai_tower.is_finished
			player_turn
			ai_turn
		end

		if @player_tower.is_finished
			puts "Congratz player! You won!"
		else
			puts "Computer wins. Here is his tower:"
			print_tower(@Ai.ai_tower)
		end


	end

	def print_tower(tower)
		values = []
		tower.tower.each { |i| values << i.value }
		puts values.join("\n")
		
	end

	def start_game(input_string)
		user_input = input_string.scan(/\w+/)
		user_input = user_input.map(&:to_i)

		if user_input.empty? or user_input[0].zero? or user_input[1].zero?
			puts "Bad input! Must be <int> <int>"
			@exit = false
		elsif user_input[0] >= user_input[1]
			puts "First value must be smaller than the second!"
			@exit = false
		else
			initialize_towers(user_input[0], user_input[1])
			@exit = true
		end
		
	end

	def initialize_towers(height, max_value)
		ai_tower     = Tower.new(height, max_value).generate_tower_blocks
		@Ai = Ai.new(ai_tower)
		@player_tower = Tower.new(height, max_value).generate_tower_blocks
	end

	def player_turn
		 @block =  @player_tower.generate_block
		 puts "Generated value is #{@block.value} .Do you want to use this value or skip turn?(yes/no)"
		 print_tower(@player_tower)
		 user_decision gets
	end

	def ai_turn
		@block = @Ai.ai_tower.generate_block
		@Ai.next_move(@block)
	end

	def user_decision(input_string)
		formated_input = input_string.scan(/\w+/)
		if formated_input[0] == "yes"
			puts "At which position?(number)"
			position= get_position gets
			@player_tower.swap_at(position.to_i.pred, @block)
			puts "Your tower:"
			print_tower(@player_tower)
			puts "\n"
		elsif formated_input[0] == "no"
			puts "Ok. Computers turn."
		else
			puts "Bad input. Must be (yes/no)"
			user_decision gets
		end
	end
	
	def get_position(position)
		formated_input = position.scan(/\d+/)
		if formated_input[0].to_i > @player_tower.height
			puts "Position must be smaller than #{@player_tower.height}"
			get_position gets
		else
			 formated_input[0]
		end
	end
	
end
# p t = Tower.new(10, 50)
# values = []
# t.tower.each { |i| values << i.value }
# puts values.join("\n")
# # t.tower.each { |i| puts i.value }
Cli.new.run