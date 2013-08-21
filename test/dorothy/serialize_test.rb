require File.expand_path(File.basename( __FILE__) + '/../test_helper.rb')
require 'dorothy'

class TestSerialize < MiniTest::Unit::TestCase

  F  = "#{File.dirname( __FILE__ )}/programs/read.z5"
  ZP = Z::Program[F]
  M = ZP.memory

  def test_no_exceptions
    zm = Z::Machine.new( ZP )

    assert( Marshal.dump( zm ) )
    assert( Marshal.load( Marshal.dump( zm ) ) )
  end

  def test_run
    zm = Z::Machine.new( ZP )

    n = zm.pc
    s = Marshal.dump( zm )

    assert( s )

    assert( zm.step )
    refute_equal( n, zm.pc )

    zm2 = Marshal.load( s )
    assert_equal( n, zm2.pc )
  end

  def test_compare
    zm = Z::Machine.new( ZP )
    zm2 = Marshal.load( Marshal.dump( zm ) )
    assert_equal(zm2.memory,zm.memory)
  end

end

