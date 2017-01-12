module CSVManager
  class Export
    def initialize
      @logger = Logging.logger(STDOUT)
      @logger.level = :debug
    end

    # Calls `send_data` with text from `to_csv(obj)` and option hash.
    # Then returns a CSV formatted string in an array.
    # [params]
    # - controller: controller that takes care of "download CSV" request. eg) products_controller
    # - objs: model instances. eg) Product.all, Product.where(category: "office")
    # - filename: a filename string. eg) "inventory_2016.csv"
    def download(controller, objs, filename=nil)
      return if controller.nil? || objs.nil?
      @logger.info "#{LINER}CSVManager::Export#download {controller: #{controller}, objs: #{objs}, filename: #{filename}}#{LINER}"
      controller.send_data to_csv(objs), filename: filename
    end

    # Generates a CSV formatted string with headers and given objects(objs).
    # [params]
    # - objs: model instances. eg) [product1, product2], Product.all
    def to_csv(objs)
      return unless validate(objs)

      if objs.is_a?(Array)
        model = objs.first.class
      else
        model_str = objs.class.to_s.split("::").first
        model = Object.const_get(model_str)
      end
      cols = model.column_names

      csv_file = CSV.generate do |csv|
        csv << cols
        objs.each do |x|
          csv << x.attributes.values_at(*cols)
        end
      end

      return csv_file
    end

    # Checks to see if an instance of ActiveRecord::Relation or an array of instance of ActiveRecord::Base is passed in.
    # [params]
    # - objs: model instances
    def validate(objs)
      valid = false

      if objs.is_a?(Array)  # eg) Product[0..10].class == Array
        objs.each do |obj|
          valid = true if obj.is_a?(ActiveRecord::Base)
        end
      else  # eg) Product.all.class == ActiveRecord::Relation
        valid = true if objs.is_a?(ActiveRecord::Relation)
      end

      return valid
    end

  end
end
