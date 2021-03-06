Step 1) Route to HomeController#import_csv
```ruby
# routes.rb
resources :home do
  collection { post :import_csv }
end
...
```

Step 2) When we choose a CSV file from the view, we can get the file name from `params`.
```ruby
# home_controller.rb
class HomeController < ApplicationController
  def import_csv
    @import = CSVManager::Import.new
    @import.parse(params[:file])
  end
  ...
end
```

Step 3) Create the form where we can choose a CSV file.
```html
<!-- # home/index.html.erb -->
<%= form_tag import_csv_home_index_path, multipart: true do %>
  <%= label_tag :file %>
  <%= file_field_tag :file %>
  <%= submit_tag 'Import CSV' %>
<% end %>
```

Step 4) After CSV file is parsed, we can use `cols`, `rows`, `entire`, `count` and `get_contents` methods.
```ruby
@import.cols                     #=> ["name", "category", "quantity"]
@import.rows                     #=> [["eraser", "stationery", 100], ["spoon", "kitchen", 110]]
@import.entire                   #=> [{"name"=>"eraser", "category"=>"stationery", "quantity"=>100}, {"name"=>"spoon", "category"=>"kitchen", "quantity"=>110}]
@import.count                    #=> 2

@import.get_contents("name")     #=> ["eraser", "spoon"]
@import.get_contents("category") #=> ["stationery", "kitchen"]
@import.get_contents("quantity") #=> [100, 110]
```
