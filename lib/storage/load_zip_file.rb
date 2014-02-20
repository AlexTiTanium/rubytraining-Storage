require 'zip/filesystem'

#
# Mixin for load from zip support
#
module Storage
  module LoadZip

    # Load from zip
    #
    # @param [ String ] path
    #
    # @since 0.0.1
    def load_from_zip(path)

      Zip::File.open(path) do |zf|
        zf.file.open('strings.dat', 'r') { |os|  self <<  JSON::parse(os.gets) }
      end

    end

    # Save file to zip
    #
    # @param [ String ] path
    #
    # @since 0.0.1
    def save_to_zip(path)

      Zip::File.open(path, Zip::File::CREATE) do |zf|
        zf.file.open('strings.dat', 'w') { |os| os.puts self.to_a.to_json }
      end

    end

  end
end