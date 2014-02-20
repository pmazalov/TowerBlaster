require_relative "./towers.rb"

class Ai

  attr_accessor :ai_tower, :interval
  def initialize(ai_tower)
    @ai_tower = ai_tower
    @interval = 0
  end

  def next_move(block)
    if @interval.zero?
      get_interval
    end

    if block.value == ai_tower.max_value
      position = ai_tower.height.pred
    else
      position = block.value / interval
    end

    ai_tower.swap_at(position, block)
  end

  def get_interval
    @interval = @ai_tower.max_value / @ai_tower.height
  end
end