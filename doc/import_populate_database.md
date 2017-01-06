Step 1) Route to HomeController#save_all
```ruby
# routes.rb
resources :home, only: [] do
  collection { post :save_all }
end
...
```

Step 2) `create` populates product database with data from `@import`.
```ruby
# home_controller.rb
class HomeController < ApplicationController
  def save_all
    @import = CSVManager::Import.new
    @import.parse(params[:file])
    @import.create(Product)
    ...
  end
  ...
end
```

Step 3) Create the form where we can choose a CSV file.
```html
<!-- # home/index.html.erb -->
<%= form_tag save_all_home_index_path, multipart: true %>
  <%= label_tag :file %>
  <%= file_field_tag :file %>
  <%= submit_tag 'Import CSV & Save' %>
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
