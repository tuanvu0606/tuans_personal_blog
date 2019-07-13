class Student < ApplicationRecord
  belongs_to :user
  belongs_to :faculty
  has_many :article
end
