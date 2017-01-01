$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "csv_manager"

class Product < ActiveRecord::Base
  def self.column_names
    ["name","category","quantity"]
  end

  def self.all

  end

  def attributes

  end
end
