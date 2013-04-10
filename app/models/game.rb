class Game < ActiveRecord::Base
  attr_accessible :uuid, :has_ended

  has_many :questions, :dependent => :destroy, :primary_key => :uuid

end
