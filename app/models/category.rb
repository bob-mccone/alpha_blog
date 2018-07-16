#Category class, need this to pass the test
class Category < ActiveRecord::Base
  #Validation for name must exist and be between 3 and 25 characters
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  #validation for name uniqueness
  validates_uniqueness_of :name
end