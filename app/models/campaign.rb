class Campaign < ActiveRecord::Base

  has_many :tokens
  has_many :players

end