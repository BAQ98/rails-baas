# frozen_string_literal: true

class Auth < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable,  and :omniauthable, :lockable,

  has_one :profile, dependent: :destroy
  before_create :build_profile
  accepts_nested_attributes_for :profile

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
end
