require 'json'

#
# Mixin for load from file support
#
module Storage
  module LoadFile

    # Load from zip
    #
    # @param [ String | File ] path_or_file
    #
    # @since 0.0.1
    def load_from_file(file)

      file = File.new(file, 'r') if file.is_a? String
      self << JSON::parse(file.read)
      file.close
    end

    # Save file to zi
    #
    # @param [ String | File ] path
    #
    # @since 0.0.1
    def save_to_file(file)

      file = File.new(file, 'w') if file.is_a? String
      file.write self.to_a.to_json
      file.close
    end

  end
end