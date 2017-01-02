require "active_record"
require "action_controller"
require "action_dispatch"
require "csv_manager"
require "support/models"
require "support/controllers"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
load File.dirname(__FILE__) + '/support/schema.rb'
