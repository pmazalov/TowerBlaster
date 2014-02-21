class Block

  attr_accessor :value, :smaller_than_bottom
  def initialize(value)
    @value              = value
    @smaller_than_bottom = :unknown
  end
  
end

class Tower
  attr_reader :height, :max_value, :is_complete, :tower

  def initialize(height, block_max_value)
    @height      = height
    @max_value   = block_max_value
    @is_complete = false
    @tower = []

  end
  
  def is_valid_value(value)
    value <= max_value
  end

  def generate_tower_blocks(block_values = nil)
    block_values ||= (1..max_value).to_a.shuffle[0,height]
    @tower = block_values.map { |i| Block.new(i) }
    adjust_block_relation
    until is_finished == false
      generate_tower_blocks
    end

    self
  end

  def is_finished
    is_complete = @tower.all? { |i| i.smaller_than_bottom == true }
  end

  def generate_block
    loop do
      number = rand(1..max_value)
      return Block.new(number) unless @tower.any? { |i| i.value == number }
    end
  end

  def swap_at(coordinate, block)
    @tower[coordinate] = block
    adjust_block_relation
    is_finished
  end

  def adjust_block_relation
    0.upto(height - 2).each do |i|
      if @tower[i].value < @tower[i.next].value
        @tower[i].smaller_than_bottom = true
      else
        @tower[i].smaller_than_bottom = false
      end
    end
    @tower.last.smaller_than_bottom = true
  end
end