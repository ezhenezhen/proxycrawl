class Proxy < ApplicationRecord
  belongs_to :crawler
  validates_presence_of :ip, :port
  validates :ip, uniqueness: { scope: :port }
  validates_numericality_of :port
end
