module CSVManager
  class Import
    attr_reader :cols, :rows, :entire, :error

    # [Instance variables]
    # - @cols: an array of CSV headers. eg) ["category", "name", "price"]
    # - @rows: an array of arrays which consist of values in each row of CSV file. eg) [["fruit", "apple", 1], ["fruit", "banana", 0.5]]
    # - @entire: an array of hashes which consist of keys and values of CSV file. Keys are headers and values are data under the header columns. eg) [{"category"=>"fruit", "name"=>"apple", "price"=>1}, {"category"=>"fruit", "name"=>"banana", "price"=>0.5}]
    # - @error: an error message string
    def initialize
      @logger = Logging.logger(STDOUT)
      @logger.level = :debug

      @cols = []
      @rows = []
      @entire = []
      @error = nil
    end

    # Reads the given CSV file, parses and sets @cols, @rows and @entire.
    # If CSV file is not readable, the error message assigns to @error without throwing an exception.
    # [params]
    # - file: CSV file path string
    # - headers: true(CSV file includes headers.) OR string type("category,name,price") OR array type(["category","name","price"])
    def parse(file, headers=true)
      return if file.nil?
      file = file.path if file.respond_to?(:path)

      begin
        raw_rows = CSV.read(file, headers: headers, converters: :numeric).to_a
      rescue
        @error = "ERROR! #{$!.message}"
        @logger.warn "#{LINER}CSVManager::Import#parse {file: #{file}, headers: #{headers}}\n#{@error}#{LINER}"
        return
      end

      @cols = raw_rows.shift
      @rows = raw_rows

      @entire = []
      CSV.foreach(file, headers: headers, converters: :numeric) do |row|
        @entire << row.to_hash
      end
    end

    # Counts the number of rows in CSV file which was parsed in `parse` method.
    # Note: Before calling this method, `parse` has to be called first.
    def count
      @rows.count
    end

    # Returns an array of values related to `col`
    # [params]
    # - col: a header string. eg) "category", "name"...
    def get_contents(col)
      @entire.map {|hash| hash[col]}
    end

    # Populates `model` with `hash_arr` array
    # Note: Before calling this method, `parse` has to be called first.
    # [params]
    # - model: model object eg) Call create(Product), NOT create("Product")
    # - hash_arr: an array of hashes. eg) [{"name"=>"doll", "category"=>"Toys", "quantity"=>8}, {"name"=>"ribbon", "category"=>"craft", "quantity"=>10}]
    def create(model, hash_arr=@entire)
      return if model.nil? || hash_arr.nil? || !validate(model, hash_arr)

      for hash in hash_arr
        model.create(hash)
      end
    end

    # Checks if `hash_arr` is an array and
    # attributes of `model` match with keys of the hash from `hash_arr`.
    # [params]
    # - model: model object eg) Call create(Product), NOT create("Product")
    # - hash_arr: an array of hashes. eg) [{"name"=>"doll", "category"=>"Toys", "quantity"=>8}, {"name"=>"ribbon", "category"=>"craft", "quantity"=>10}]
    def validate(model, hash_arr)
      return false unless hash_arr.is_a?(Array)
      keys = hash_arr.first.keys
      cols = model.column_names[1..-3]

      if keys != cols
        @logger.warn "#{LINER}CSVManager::Import#validate | MatchError: #{keys} != #{cols} #{LINER}"
        return false
      end
      true
    end
  end
end
