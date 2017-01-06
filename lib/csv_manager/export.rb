# require 'logging'

module CSVManager
  class Export
    # def initialize
    #   @logger = Logging.logger['csv_manager_export_log.txt']
    #   @logger.level = :debug
    # end

    def download(controller, objs, filename=nil)
      # @logger.debug "DOWNLOAD METHOD CALLED"
      return if controller.nil? || objs.nil?
      controller.send_data to_csv(objs), filename: filename
    end

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

    # This method checks to see if an instance of ActiveRecord::Relation or an array of instance of ActiveRecord::Base is passed in.
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
