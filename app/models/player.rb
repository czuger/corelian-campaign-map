class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  has_many :fleet_elements
end