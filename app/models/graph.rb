class Graph < ActiveRecord::Base
  attr_accessible :description, :name, :query, :server

  belongs_to :server
end
