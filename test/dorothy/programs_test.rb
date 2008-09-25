require 'test/unit'
require 'yaml'

require 'dorothy'

class TestPrograms < Test::Unit::TestCase

  PROGRAMS_DIR = "#{File.dirname( __FILE__ )}/programs"

  Dir["#{PROGRAMS_DIR}/*.inf"].each do |fn|

    zf = "#{PROGRAMS_DIR}/#{File.basename( fn, '.inf' )}.z5"
    tm = "test_#{File.basename( fn, '.inf' )}"

    output_yaml, reading_output_yaml = "", nil
    open( fn, "r" ) do |f|
      while s = f.gets
        if s =~ /^\! output:/
          reading_output_yaml = true
        elsif reading_output_yaml 
          if s =~ /^\! (.*)/
            output_yaml += $1 + "\n"
          else
            reading_output_yaml = false
          end
        end
      end
    end

    expected_output = YAML::load( output_yaml ) if output_yaml

    if expected_output
      define_method( tm ) do
        __test_program( zf, expected_output )
      end
    end
  end


  def __test_program( filename, expected_output )
    m = Machine.new( filename )

    i = 0
   
    until m.finished? 
      m.step while m.output.empty? && ! m.finished?

      while s = m.output.shift

        assert( i < expected_output.length, "unexpected output #{s}, " +
                "only expecting #{expected_output.length} tokens.  " +
                "Trace: \n#{m.trace.join}" )

        assert_equal( expected_output[i], s, 
                      "output (token #{i}) doesn't match expected.  " +
                      "Trace: \n#{m.trace.join}" )

        i += 1
      end
    end

    assert_equal( expected_output.length, i,
                  "expected #{expected_output.length} output tokens, " +
                  "received #{i}.  Trace: \n#{m.trace.join}" )
  end

end
