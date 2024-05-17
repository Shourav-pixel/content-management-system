class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable
  
  attribute :roles, :integer
  enum :roles, { user: 0, admin: 1 }
  # after_initialize :set_default_role, if: :new_record?
  # def set_default_role
  #   self.role ||= :user
  # end
  enum status: { active: "active", blocked: "blocked", deleted: "deleted" }
  has_many :books
  has_many :likes
  has_many :comments, dependent: :destroy
  def blocked_or_deleted?
    blocked? || deleted?
  end

  # Method to block the user
  def block!
    update(status: :blocked)
  end

  # Method to unblock the user
  def unblock!
    update(status: :active)
  end

  # Method to delete the user
  def delete!
    update(status: :deleted)
  end

  # Override Devise's active_for_authentication? method to handle blocked or deleted users
  def active_for_authentication?
    super && !blocked_or_deleted?
  end

  # Override Devise's inactive_message method to customize the error message for blocked or deleted users
  def inactive_message
    blocked? ? :blocked : super
  end
end
