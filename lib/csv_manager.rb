require "csv_manager/version"
require "csv"
require "pry"

module CSVManager
  class Import
    attr_reader :cols, :rows, :entire

    def initialize(file, headers=true)
      parse_csv(file, headers)
    end

    def parse_csv(file, headers)
      file = file.path if file.respond_to?(:path)

      raw_rows = CSV.read(file)
      @cols = raw_rows.shift if headers
      @rows = raw_rows

      @entire = []
      CSV.foreach(file, headers: headers) do |row|
        @entire << row.to_hash
      end
    end

    def count
      @rows.count
    end

    def get_contents(col)
      @entire.map {|hash| hash[col]}
    end
  end
end
