module CSVManager
  class Export
    def download(objs)
      # model_str = objs.class.to_s.split("::").first
      # model = Object.const_get(model_str)
      # ctrl_str = model.table_name.capitalize + "Controller"
      # ctrl = Object.const_get(ctrl_str)

      ActionController::MimeResponds.respond_to do |format|
        format.html
        format.csv { render text: to_csv(objs) }
      end
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
