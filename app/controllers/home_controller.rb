class HomeController < ApplicationController
    def index
        render template: 'admin/users/index'
    end
end
  