class JiraService
  def self.create_issue(fields)
    url = 'https://scorefield1998.atlassian.net/rest/api/2/issue'
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + Base64.strict_encode64('scorefield1998@gmail.com:ATATT3xFfGF0CFVr4MvF3XuwTtmtpquVD0TnYs3Zm5iVsWfzxdu-Lm1SsuArzqKk5qikKEIUMgmZqaek1RhROkQmYfWxfY5iVZiFo7-ycTY1YyEZ_HTHBUBIfaL77YKA8kMwc_-eA6N2667zMOZld1daB_xBi7qDE1iJ6FqA4kYVgQR747Go2Gw=0DEADD9D')
    }

    begin
      response = RestClient.post(url, fields.to_json, headers)
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      # Handle exceptions here
      puts "Error: #{e.response}"
      return nil
    end
  end
end
