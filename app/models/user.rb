class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum user_type: [:donor, :aidpioneer, :admin]

  has_many :donations, class_name: "Pallet", source: :donor
  has_many :shipments

  validates :email,
            format: { with: /^(.+)@(.+)$/, message: "Email invalid" },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
