# CSVManager

This gem helps import/export a CSV file in a very easy and simple way.

```ruby
# Import a CSV file and parse the file
import = CSVManager::Import.new
import.parse('tmp/default.csv')
import.create(Product)

# Export a CSV file and download it
export = CSVManager::Export.new
export.download(products_controller, Product.all, "my_file.csv")
```

## Installation

Add this line to Gemfile, then execute `$ bundle`.
```ruby
gem 'csv_manager'
```
Or install it yourself as:
```bash
$ gem install csv_manager
```

## Usage

### How to Import
First instantiate `CSVManager::Import` class.
```ruby
@import = CSVManager::Import.new
```

Import a CSV file and `parse` the file. Then `@import` can call `cols`, `rows`, `entire`, `count` and `get_contents`.
```ruby
@import.parse('tmp/default.csv')

@import.cols                     #=> ["name", "category", "quantity"]
@import.rows                     #=> [["eraser", "stationery", 100], ["spoon", "kitchen", 110]]
@import.entire                   #=> [{"name"=>"eraser", "category"=>"stationery", "quantity"=>100}, {"name"=>"spoon", "category"=>"kitchen", "quantity"=>110}]
@import.count                    #=> 2
@import.get_contents("category") #=> ["stationery", "kitchen"]
```

Customized headers can be sent as a second argument to `parse`.
```ruby
@import.parse('tmp/default.csv', ["Name", "Type", "Count"])
```

Populate database with data from `@import`
```ruby
@import.create(Product)
#<Product id: 27, name: "eraser", category: "stationery", quantity: 100, created_at: "2017-01-06 17:14:09", updated_at: "2017-01-06 17:14:09">
#<Product id: 28, name: "spoon", category: "kitchen", quantity: 110, created_at: "2017-01-06 17:14:09", updated_at: "2017-01-06 17:14:09">CSV
```

* [Example 1) Choose a CSV file and parse](doc/import_choose_csv_and_parse.md)
* [Example 2) Create custom headers](doc/create_custom_headers.md)
* [Example 3) Specify a CSV file path](doc/import_specify_csv_path.md)
* [Example 4) Populate Database](doc/import_populate_database.md)

-----

### How to Export
First instantiate `CSVManager::Export` class.
```ruby
@export = CSVManager::Export.new
```

Create a CSV file with the given model.
```ruby
@export.download(products_controller, Product.all, "my_file.csv")
```

In the view, make sure to send `format: "csv"` to the path.
```html
<%= link_to 'Download CSV', download_products_path(format: "csv") %>
```

* [Example 5) Download database in a CSV file](doc/export_download.md)


## Demo App
To see the `CSVManager` in action you can take a look at this app - [Inventory](https://inventory-ghbooth12.herokuapp.com).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ghbooth12/csv_manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
