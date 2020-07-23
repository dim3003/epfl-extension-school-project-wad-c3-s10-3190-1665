class User < ApplicationRecord
  has_many :comments
  has_many :pins

  has_and_belongs_to_many :goals, class_name: 'Pin'
end
