module CSVManager
  class Export
    def download(controller, objs)
      controller.send_data to_csv(objs)
    end

    def to_csv(objs)
      model_str = objs.class.to_s.split("::").first
      model = Object.const_get(model_str)
      cols = model.column_names

      CSV.generate do |csv|
        csv << cols
        model.all.each do |x|
          csv << x.attributes.values_at(*cols)
        end
      end
    end

  end
end
