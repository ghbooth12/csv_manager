Step 1) Route to ProductsController#download
```ruby
# routes.rb
resources :products do
  collection { get :download_list }
end
...
```

Step 2) Get a CSV formatted string by calling `download` on the instance of `CSVManager::Export` class. We can specify certain data such as `Product.where(quantity: 0)`. We can also name the CSV file. (If file name is omitted, the CSV file will be named after the method name. In this case, the CSV file will be `download_list.csv` if file name is omitted.)
```ruby
# products_controller.rb
class ProductsController < ApplicationController
  def download_list
    CSVManager::Export.new.download(self, Product.all, "products-#{Date.today}.csv")
  end
  ...
end
```

Step 3) Make sure to send `format: "csv"` to the path.
```html
<!-- # products/index.html.erb -->
<%= link_to 'Download CSV', download_list_products_path(format: "csv") %>
```
