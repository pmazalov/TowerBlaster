require "test/unit"
require "../ai.rb"

class TestAi < Test::Unit::TestCase
	
	def setup
  end

  def test_ai_logic
  	tower = Tower.new(3, 50).generate_tower_blocks([5, 10, 8])
  	
  	assert_equal tower.height, 3
  end
	
end