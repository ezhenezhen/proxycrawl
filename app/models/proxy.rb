class Proxy < ApplicationRecord
  belongs_to :crawler
  validates_presence_of :ip, :port
  validates_numericality_of :port
end
