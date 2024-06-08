require 'jira-ruby'

jira_secrets = Rails.application.secrets.jira

options = {
  username: jira_secrets[:username],
  password: jira_secrets[:api_token],
  site: jira_secrets[:site],
  context_path: '',
  auth_type: :basic,
}

JIRA_CLIENT = JIRA::Client.new(options)
