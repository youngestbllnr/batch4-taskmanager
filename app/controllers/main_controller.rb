class MainController < ApplicationController
    before_action :authenticate_user!, except: :index

    def index
        if current_user.present?
            redirect_to dashboard_path
        end
        session.delete(:dev)
    end

    def dashboard
        redirect_to root_url if current_user.nil?
        @categories = current_user.categories
    end

    def today
        @checked_today = []
        @unchecked_today = []
        categories = current_user.categories
        categories.each do |category|
            category.tasks.each do |task|
                @checked_today.push(task) if task.due_date == Date.today && task.is_checked
                @unchecked_today.push(task) if task.due_date == Date.today && !task.is_checked
            end
        end
    end

end
