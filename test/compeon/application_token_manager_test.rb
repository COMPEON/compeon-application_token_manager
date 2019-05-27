require 'test_helper'

class Compeon::ApplicationTokenManagerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Compeon::ApplicationTokenManager::VERSION
  end
end
