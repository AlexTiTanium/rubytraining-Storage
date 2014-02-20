require 'helper'

##
# Test class

class TestStorageTrie < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup

    @storage = Storage::Trie.new

    @storage.add('java')
    @storage.add('java script')
    @storage.add('perl')
    @storage.add(['rust', 'Smalltalk'])

    @storage.add('Scheme')
  end

  ##
  # Check if methods exist
  def test_respond_to

    assert_respond_to @storage, :add
    assert_respond_to @storage, :contains?
    assert_respond_to @storage, :find

  end

  ##
  #
  def test_contains?

    assert @storage.contains?('java')
    assert @storage.contains?('java script')
    assert @storage.contains?('perl')
    assert @storage.contains?('Smalltalk')

    assert !@storage.contains?('cpp')
    assert !@storage.contains?('cobol')

  end

  ##
  #
  def test_find

    assert_raise Storage::BadFindRequest do
      @storage.find('ja')
      @storage.find('j')
      @storage.find('')
    end

    assert_equal ['java', 'java script'], @storage.find('java')
    assert_equal ['java', 'java script'], @storage.find('jav')

    assert_equal ['Smalltalk'], @storage.find('Smalltalk')
    assert_equal ['smalltalk'], @storage.find('smalltalk')

    assert_equal ['Rust'], @storage.find('Rust')

    assert_equal [], @storage.find('xxx')

  end

  ##
  #
  def test_add

    @storage.add('ruby')
    assert_equal ['ruby'], @storage.find('ruby')
    assert @storage.contains?('ruby')

    @storage.add('python', 'objective-c')
    assert_equal ['python'],      @storage.find('python')
    assert_equal ['objective-c'], @storage.find('objective-c')
    assert @storage.contains?('python')
    assert @storage.contains?('objective-c')

    @storage.add(%w(Lisp Lua))
    assert_equal ['Lua'], @storage.find('Lua')
    assert_equal ['Lisp'], @storage.find('Lisp')
    assert @storage.contains?('Lua')
    assert @storage.contains?('Lisp')

    @storage << 'bistro'
    assert_equal ['bistro'], @storage.find('bistro')

    @storage << ['Chef', 'Cool']
    assert_equal ['Chef'], @storage.find('Chef')
    assert_equal ['Cool'], @storage.find('Cool')

    @storage << ['DataFlex', 'Datalog']
    assert_equal ['Dataflex', 'Datalog'], @storage.find('Data')

  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

end