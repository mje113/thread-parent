require 'helper'

class TestThreadParent < MiniTest::Unit::TestCase

  include ThreadParent

  def setup
    Thread.current[:a] = 'a'
  end

  def test_is_a_thread_parent
    thread = Thread.new { 'work' }
    assert_kind_of ThreadParent::Thread, thread
  end

  def test_can_have_parent
    thread = Thread.new { 'work' }.join
    assert_equal Thread.current, thread.parent
  end

  def test_can_find_thread_variable_in_parent
    thread = Thread.new { 'work' }.join
    assert_equal 'a', thread[:a]
  end

  def test_can_find_thread_variable_in_parents_parent
    Thread.new {
      Thread.new {
        assert_equal 'a', Thread.current[:a]
      }.join
    }.join
  end

  def test_can_override_parents_thread_variable
    thread = Thread.new {
      Thread.current[:a] = 'b'
    }.join

    assert_equal 'b', thread[:a]
  end

  def test_wont_break_parent_threads_scope
    Thread.new { Thread.current[:a] = 'b' }.join
    thread = Thread.new { 'work' }.join
    assert_equal('a', thread[:a])
  end
end