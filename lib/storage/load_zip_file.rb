require 'zip/filesystem'

#
# Mixin for load from zip support
#
module Storage
  module LoadZip

    # Load from zip
    #
    # @param [ String | File | IO ] file
    #
    # @since 0.0.1
    def load_from_zip(file)

      Zip::InputStream.open(file) do |io|
        io.get_next_entry
        self <<  JSON::parse(io.read)
      end

    end

    # Save file to zip
    #
    # @param [ String | File | IO ] file
    #
    # @since 0.0.1
    def save_to_zip(file)

      Zip::OutputStream.open(file) do |io|
         io.put_next_entry("strings.dat")
         io.write self.to_a.to_json
      end

    end

  end
end