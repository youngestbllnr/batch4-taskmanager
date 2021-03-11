class User < ApplicationRecord
  has_many :categories, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, allow_blank: false, presence: true
  validates :lastname, allow_blank: false, presence: true
end
