class MainController < ApplicationController
    before_action :authenticate_user!, only: [ :dashboard ]

    def index
    end

    def dashboard
        @categories = current_user.categories
    end

    def dev
    end

    def today
    end

end
