class Sock < ApplicationRecord
  validates_presence_of :ip, :port
  validates_uniqueness_of :ip, scope: :port
end
