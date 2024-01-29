class Profile < ApplicationRecord
  belongs_to :auth
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300], resize_to_fill: [300, 300]
  end

  validates :username, uniqueness: true
  validates :avatar,
            size: { less_than: 1.megabyte, message: 'Picture is too large' },
            content_type: { in: [:png, :jpeg, :jpg], message: 'Must be PNG, JPEG' }
  has_many :kanbans, foreign_key: :author_id

  # assignees kanban
  has_many :kanban_assignees
  has_many :kanbans, through: :kanban_assignees

  def self.with_auth
    includes(:auth).where.not(auths: { id: nil })
  end
end
