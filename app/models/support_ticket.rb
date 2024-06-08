class SupportTicket < ApplicationRecord
  belongs_to :user
  belongs_to :storage

  validates :summary, presence: true
  validates :priority, presence: true

  # Additional fields for storing Jira info
  attribute :jira_key, :string
  attribute :jira_url, :string
end
