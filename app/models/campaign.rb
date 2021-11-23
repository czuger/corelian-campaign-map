require_relative 'token'

class Campaign < ActiveRecord::Base

  has_many :tokens, dependent: :destroy
  has_many :players, dependent: :destroy

end