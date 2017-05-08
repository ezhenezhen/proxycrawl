class Crawler < ApplicationRecord
  validates_presence_of :name, :link
  validates_uniqueness_of :name
  has_many :proxies
end
