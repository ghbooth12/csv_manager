Step 1) Route to HomeController#quick_import
```ruby
# routes.rb
get 'quick_import' => 'home#quick_import'
...
```

Step 2) We can specify the file path directly in the `parse` method.
```ruby
# home_controller.rb
class HomeController < ApplicationController
  def quick_import
    @import = CSVManager::Import.new
    @import.parse('tmp/default.csv')
    ...
  end
  ...
end
```

Step 3) (Optional) Create a link that executes `quick_import`
```html
<!-- # home/index.html.erb -->
<%= link_to 'Quick Default Import', quick_import_path %>
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
