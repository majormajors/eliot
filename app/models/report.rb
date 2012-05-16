class Report < ActiveRecord::Base
  attr_accessible :description, :name, :queries
  serialize :queries, Array

  belongs_to :server

  def to_s
    self.name.to_s
  end
end
