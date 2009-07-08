require 'rubygems'
require 'minitest/unit'
require 'rdoc/markup'
require 'rdoc/generator/chm'

class TestRDocGeneratorCHM < MiniTest::Unit::TestCase

  def setup
    @m = RDoc::Markup.new
    @am = RDoc::Markup::AttributeManager.new
    @chm = RDoc::Generator::CHM.new
  end

  def test_generate
    assert_equal(@chm.generate, 0)
  end
end