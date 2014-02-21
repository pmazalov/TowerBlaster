require "test/unit"
require "../towers.rb"

class TestTower < Test::Unit::TestCase
  def setup
  end

  def test_generate_tower_blocks
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks
    
    refute_empty tower.tower
  end

  def test_creation_of_tower
    tower = Tower.new(10, 50)

    assert_equal tower.height, 10
    assert_equal tower.max_value, 50
    assert_equal tower.is_complete, false
    assert_equal tower.tower, []
    assert_equal tower.score, 0
  end

  def test_if_tower_is_finished
    tower = Tower.new(10, 50)

    assert_equal tower.is_finished, true
  end
  
  def test_if_block_fits_in_tower
    tower = Tower.new(10, 50)
    block = Block.new(51)

    assert_equal tower.is_valid_value(block.value), false
  end

  def test_if_two_towers_are_unique
    tower1 = Tower.new(10, 50)
    tower1.generate_tower_blocks

    tower2 = Tower.new(10, 50)
    tower2.generate_tower_blocks

    refute_equal tower1.tower, tower2.tower
  end

  def test_if_swap_works
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks
    block = Block.new(40)
    
    tower.swap_at(9, block)

    assert_equal tower.tower[9], block
  end

  def test_if_can_swap_values
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks
    block = Block.new(40)
    
    tower.swap_at(9, block)

    assert_equal tower.tower[9].value, block.value
  end

  def test_block_relations_in_tower
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks

    assert_equal tower.tower.all? { |i| i.smaller_than_bottom != :unknown }, true
  end

  def test_generate_block_makes_unique_block_not_included_in_tower
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks
    block = tower.generate_block

    assert_equal tower.tower.all? { |i| i.value != block.value}, true
  end

  def test_block_relation_after_swap
    tower = Tower.new(10, 50)
    tower.generate_tower_blocks
    block = Block.new(40)
    
    tower.swap_at(9, block)

    refute_equal tower.tower[9].smaller_than_bottom == :unknown, true
  end

  def test_block_relation_after_swaping_last_block
    tower = Tower.new(20, 50)
    tower.generate_tower_blocks
    block = Block.new(40)
    
    tower.swap_at(19, block)

    assert_equal tower.tower[19].smaller_than_bottom, true
  end

  def test_if_generated_tower_is_finished
    tower = Tower.new(3, 4)
    tower.generate_tower_blocks

    assert_equal tower.is_finished, false
  end

  def test_generated_tower_is_correct
    tower = Tower.new(3, 4)
    tower.generate_tower_blocks([1, 2, 4])

    assert_equal tower.is_finished, false
  end

  def test_score
    tower = Tower.new(4, 5)
    tower.generate_tower_blocks([2, 1, 4, 5])
    block = Block.new(3)

    tower.swap_at(1, block)

    assert_equal tower.score, 10 ** 4
    assert_equal tower.modify_score(1), 2 * (10 ** 4)
  end
  def test_count_score
    test_values = [5 ,6, 7, 3]
    tower = Tower.new(4, 10)
    tower.generate_tower_blocks(test_values)

    assert_equal tower.count_score(test_values, -1), 2
    assert_equal tower.count_score([2, 3, 4, 5, 6, 7], -1), 5
    assert_equal tower.count_score([1, 5, 2, 3, 4, 5], -1), 0
  end

end