module CSVManager
  class Import
    attr_reader :cols, :rows, :entire, :error

    def initialize
      @cols = []
      @rows = []
      @entire = []
      @error = nil
    end

    def parse(file, headers=true)
      return if file.nil?
      file = file.path if file.respond_to?(:path)

      begin
        raw_rows = CSV.read(file, headers: headers, converters: :numeric).to_a
      rescue
        @error = "ERROR! #{$!.message}"
        return
      end

      @cols = raw_rows.shift
      @rows = raw_rows

      @entire = []
      CSV.foreach(file, headers: headers, converters: :numeric) do |row|
        @entire << row.to_hash
      end
    end

    def count
      @rows.count
    end

    def get_contents(col)
      @entire.map {|hash| hash[col]}
    end

    # Before calling this method, `parse` has to be called first.
    def create(model, hash_arr=@entire)
      return if model.nil?
      for hash in hash_arr
        model.create(hash)
      end
    end
  end
end
