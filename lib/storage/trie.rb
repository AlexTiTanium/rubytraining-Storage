
module Storage

  #
  # Class implement trie algorithm also called digital tree and sometimes radix tree or prefix
  # tree (as they can be searched by prefixes), is an ordered tree
  # data structure that is used to store a dynamic set or associative
  # array where the keys are strings.
  #
  # @since 0.0.1
  class Trie

    # Load file load and save support
    include Storage::LoadFile

    # Load file load zip and save zip support
    include Storage::LoadZip

    # @return [ Hash<String> ] Storage for trie container
    attr_reader :root

    # Constructor
    #
    def initialize

      @root = {}
    end

    # Add strings to trie
    #
    # @param [ String || Array<String> ] strings
    #
    # @example add('string')
    # @example add('string', 'string2')
    # @example add(['string', 'string2'])
    # @example self << ['string', 'string2']
    #
    # @since 0.0.1
    def add(*strings)

      node = @root

      # Convert to flat array
      strings.flatten!

      strings.each do |string|

        string.downcase.each_char { |char| node = node[char] ||= {} }
        node[:end] = true
        node = @root
      end

    end
    alias_method :<<, :add

    # Check if trie contains given string
    #
    # @param [ String ] string
    #
    # @example contains?('string')
    #
    # @return [ true, false ]
    #
    # @since 0.0.1
    def contains?(string)

      node = @root

      string.downcase.each_char do |char|
        return false if node.nil?
        node = node[char]
      end

      if node and node[:end]
        true
      else
        false
      end
    end

    # Returns an array of all the strings contained in the trie
    #
    # @param [ String ] string
    #
    # @return [ Array<String> ]
    #
    # @since 0.0.1
    def find(string)

      raise 'Min length of find param is 3 chars' unless string.length >= 3

      node = @root

      string.downcase.each_char do |char|
        return [] unless node[char]
        node = node[char]
      end

      to_a(node).map { |word_end| string + word_end }
    end

    # Returns an array of all the words contained in given node
    #
    # @param [ Hash ] node
    # @param [ String ] prefix
    # @param [ Array<String> ] array
    #
    # @since 0.0.1
    def to_a(node = @root, prefix = '', array = [])
      return array if node.nil?

      node.each do |key, value|

        if key == :end
          array << prefix
        else
          to_a(value, prefix + key, array)
        end

      end

      array
    end

  end
end