require "csv_manager/version"
require "csv"
require "pry"

module CSVManager
  class Import
    attr_reader :cols, :rows, :entire

    def initialize
      @cols = []
      @rows = []
      @entire = []
    end

    def parse(file, headers=true)
      return if file.nil?
      file = file.path if file.respond_to?(:path)

      begin
        raw_rows = CSV.read(file)
      rescue
        puts "\n=====\nError occurs. Please check your CSV file.\nERROR MESSAGE: #{$!.message}\n=====\n"
        return
      end

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
