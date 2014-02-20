require 'json'

#
# Mixin for load from file support
#
module Storage
  module LoadFile

    # Load from zip
    #
    # @param [ String ] path
    #
    # @since 0.0.1
    def load_from_file(path)

      File.open(path, 'r') do |file|
        self << JSON::parse(file.gets)
      end

    end

    # Save file to zi
    #
    # @param [ String ] path
    #
    # @since 0.0.1
    def save_to_file(path)

      File.open(path, 'w') do |file|
        file.puts self.to_a.to_json
      end

    end

  end
end