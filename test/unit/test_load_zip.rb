require 'helper'

##
# Test class

class TestLoadZip < Test::Unit::TestCase

  # Path to test files
  TMP_STRING_PATH = 'test/files/tmp.strings.zip'
  STRING_PATH     = 'test/files/strings.zip'

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @storage = Storage::Trie.new
  end

  ##
  # Check if methods exist
  def test_respond_to

    assert_respond_to @storage, :load_from_zip
    assert_respond_to @storage, :save_to_zip

  end

  ##
  #
  def test_load_from_zip

    @storage.load_from_zip(STRING_PATH)

    assert_equal ['php'], @storage.find('php')
    assert @storage.contains?('php')

    assert_equal ['Pascal'], @storage.find('Pascal')
    assert @storage.contains?('Pascal')

    assert_equal %w(php mathematica occam oxygene pascal seed7).sort, @storage.to_a.sort

  end

  ##
  #
  def test_load_from_zip_file

    @storage.load_from_zip(File.new(STRING_PATH))

    assert_equal ['php'], @storage.find('php')
    assert @storage.contains?('php')

    assert_equal ['Pascal'], @storage.find('Pascal')
    assert @storage.contains?('Pascal')

    assert_equal %w(php mathematica occam oxygene pascal seed7).sort, @storage.to_a.sort

  end

  ##
  #
  def test_save_to_zip_file

    @storage.add('java')
    @storage.add('java script')
    @storage.add('perl')
    @storage.add('rust')
    @storage.add('Smalltalk')
    @storage.add('Scheme')

    @storage.save_to_zip(File.new(TMP_STRING_PATH, 'wb', 0777))

    test_write = Storage::Trie.new
    test_write.load_from_zip(TMP_STRING_PATH)

    assert_equal ['java', 'java script', 'perl', 'rust', 'smalltalk', 'scheme'].sort, test_write.to_a.sort

    # Test for append load
    test_write.load_from_zip(STRING_PATH)
    assert_equal ['java', 'java script', 'perl', 'rust', 'smalltalk', 'scheme', 'php', 'mathematica', 'occam', 'oxygene', 'pascal', 'seed7'].sort, test_write.to_a.sort

  end

  ##
  #
  def test_save_to_zip

    @storage.add('java')
    @storage.add('java script')
    @storage.add('perl')
    @storage.add('rust')
    @storage.add('Smalltalk')
    @storage.add('Scheme')

    @storage.save_to_zip(TMP_STRING_PATH)

    test_write = Storage::Trie.new
    test_write.load_from_zip(TMP_STRING_PATH)

    assert_equal ['java', 'java script', 'perl', 'rust', 'smalltalk', 'scheme'].sort, test_write.to_a.sort

    # Test for append load
    test_write.load_from_zip(STRING_PATH)
    assert_equal ['java', 'java script', 'perl', 'rust', 'smalltalk', 'scheme', 'php', 'mathematica', 'occam', 'oxygene', 'pascal', 'seed7'].sort, test_write.to_a.sort

  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Delete file

  end

end