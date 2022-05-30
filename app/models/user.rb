class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum user_type: [:donor, :aidpioneer, :admin]

  has_many :donations, class_name: "Pallet", source: :donor
  has_many :shipments

  validates :first_name, presence: true
  validates :last_name, presence: true
end
