class Metric < ActiveRecord::Base
  attr_accessible :query, :report_id, :scale, :server_id

  belongs_to :server
  belongs_to :report

  def to_s
    self.query.to_s
  end
end
