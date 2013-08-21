require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'ext'))

require 'dorothy'
