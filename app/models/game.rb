class Game < ActiveRecord::Base
  has_many :questions

  attr_reader :has_ended
end
