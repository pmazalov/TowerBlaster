require "test/unit"
require "../ai.rb"

class TestAi < Test::Unit::TestCase

  def setup
  end

  def test_if_max_value_block_go_in_the_end
    tower = Tower.new(3, 50).generate_tower_blocks([5, 10, 7])
    block = Block.new(50)

    comp_tower = Ai.new(tower)
    comp_tower.next_move(block)

    assert_equal comp_tower.ai_tower.tower[2].value, 50
  end
  
  def test_if_min_value_block_go_in_the_end
    tower = Tower.new(3, 50).generate_tower_blocks([5, 10, 7])
    block = Block.new(1)

    comp_tower = Ai.new(tower)
    comp_tower.next_move(block)

    assert_equal comp_tower.ai_tower.tower[0].value, 1
  end

  def test_if_middle_value_block_go_in_the_end
    tower = Tower.new(3, 50).generate_tower_blocks([5, 10, 7])
    block = Block.new(25)

    comp_tower = Ai.new(tower)
    comp_tower.next_move(block)

    assert_equal comp_tower.ai_tower.tower[1].value, 25
  end

  def test_if_next_move_places_block_outside_tower
    tower = Tower.new(3, 5).generate_tower_blocks([1, 5, 2])
    block = Block.new(4)

    comp_tower = Ai.new(tower)
    comp_tower.next_move(block)

    assert_equal comp_tower.ai_tower.tower[2].value, 4
    assert_equal comp_tower.ai_tower.tower[4], nil
  end

  def test_if_interval_is_zero_or_one
    tower = Tower.new(3, 5).generate_tower_blocks([1, 5, 2])
    block = Block.new(4)

    comp_tower = Ai.new(tower)
    comp_tower.next_move(block)

    refute_equal comp_tower.interval, 0
    refute_equal comp_tower.interval, 1
  end
end