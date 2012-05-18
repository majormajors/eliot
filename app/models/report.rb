class Report < ActiveRecord::Base
  attr_accessible :description, :name, :queries

  belongs_to :server
  has_many :metrics

  def to_s
    self.name.to_s
  end
end
