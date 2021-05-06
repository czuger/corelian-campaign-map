require_relative 'Player'

class User < ActiveRecord::Base
  has_many :players
  has_many :campaigns, through: :players
end