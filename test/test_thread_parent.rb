require 'helper'

class TestThreadParent < MiniTest::Unit::TestCase

  def setup
    Thread.current[:a] = 'a'
  end

  def test_is_a_thread_parent
    thread = Thread.new { 'work' }
    assert_kind_of Thread, thread
  end

  def test_can_have_parent
    thread = Thread.new { 'work' }.join
    assert_equal Thread.current, thread.parent
  end

  def test_can_find_thread_variable_in_parent
    thread = Thread.new { 'work' }.join
    assert_equal 'a', thread.parents[:a]
  end

  def test_can_find_thread_variable_in_parents_parent
    Thread.new {
      Thread.new {
        assert_equal 'a', Thread.current.parents[:a]
      }.join
    }.join
  end

  def test_can_override_parents_thread_variable
    thread = Thread.new {
      Thread.current[:a] = 'b'
    }.join

    assert_equal 'b', thread.parents[:a]
  end

  def test_wont_break_parent_threads_scope
    Thread.new { Thread.current[:a] = 'b' }.join
    thread = Thread.new { 'work' }.join
    assert_equal('a', thread.parents[:a])
  end
end
