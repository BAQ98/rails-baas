class Profile < ApplicationRecord
  belongs_to :auth
  has_one_attached :avatar

  validates :username, uniqueness: true

  def self.with_auth
    includes(:auth).where.not(auths: { id: nil })
  end
end
