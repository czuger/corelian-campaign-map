require_relative 'token'

class Campaign < ActiveRecord::Base

  has_many :tokens, inverse_of: :campaign, dependent: :destroy
  has_many :players, inverse_of: :campaign, dependent: :destroy

end