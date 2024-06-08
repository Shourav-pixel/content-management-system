class TicketsController < ApplicationController
  def new
    @ticket = SupportTicket.new
  end

  def create
    fields = {
      "fields": {
        "project": { "key": "KAN" },
        "summary": params[:summary],
        "description": params[:description],
        "issuetype": { "id": 10005 },
        "customfield_10035": { "value": params[:priority] },
        "customfield_10036": { "value": params[:status] }
      }
    }

    response = JiraService.create_issue(fields)

    if response && response['key']
      # Save the issue to your SupportTicket model
      @ticket = SupportTicket.new(
        summary: params[:summary],
        priority: params[:priority],
        status: params[:status],
        user_id: current_user.id,
        storage_id: 2
      )

      if @ticket.save
        flash[:alert] = 'Issue created and saved successfully!'
      else
        Rails.logger.error @ticket.errors.full_messages.join(", ")
        flash[:alert] = 'Issue created in Jira but failed to save locally. Errors: ' + @ticket.errors.full_messages.join(", ")
      end
    else
      flash[:alert] = 'Failed to create issue in Jira.'
    end

    redirect_to new_ticket_path
  end

  def index
    @ticket = SupportTicket.all;
  end
end
