class Auth < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable,  and :omniauthable, :lockable,

  devise :database_authenticatable,
         :lockable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :password, presence: true
  validates :email, presence: true
  validates :password_confirmation, presence: true, on: :create

  validates_confirmation_of :password, on: :create

  scope :search, ->(search) { where("name LIKE ?", "%#{search}%") if search.present? }
  # Ex:- scope :active, -> {where(:active => true)}
end
