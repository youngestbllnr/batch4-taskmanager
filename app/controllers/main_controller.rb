class MainController < ApplicationController
    before_action :authenticate_user!, only: [ :dashboard, :today, :toggle_task ]

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

    def dev
        session[:dev] = 1;
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

    def toggle_task
        task = Task.find(params[:task_id])
        task.toggle!(:is_checked)
        if params[:ref] == "today"
            redirect_to today_path(anchor: "task_#{ task.id }")
        elsif params[:ref] == "category"
            redirect_to category_path(task.category, anchor: "task_#{ task.id }")
        else
            redirect_to task_path(task)
        end
    end

end
