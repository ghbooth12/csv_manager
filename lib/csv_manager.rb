require "csv_manager/version"
require "csv"
require "pry"

module CSVManager
  class Import
    attr_reader :headers, :rows

    def initialize(file, headers=true)
      parse_csv(file, headers)
    end

    def parse_csv(file, headers)
      file = file.path if file.respond_to?(:path)
      raw_rows = CSV.read(file)

      @headers = raw_rows.shift if headers
      @rows = raw_rows
    end

    def count
      @rows.count
    end
  end
end
