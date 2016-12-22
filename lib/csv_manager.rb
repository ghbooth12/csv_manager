require "csv_manager/version"
require "csv"
require "pry"

module CSVManager
  class Import
    attr_reader :headers, :rows

    def initialize(file_path, headers=true)
      raw_rows = CSV.read(file_path)

      @headers = raw_rows.shift if headers
      @rows = raw_rows
    end

    def count
      @rows.count
    end
  end
end
