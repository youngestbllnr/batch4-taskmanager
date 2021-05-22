class MainController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    redirect_to dashboard_path if current_user.present?
    session.delete(:omniauth) #DELETE OMNIAUTH SESSION
  end

  def dashboard
    @categories = current_user.categories

    # Update locale based on user's language
    I18n.locale = :fil if current_user.language == 'Filipino'
  end

  def today
    @checked_today = []
    @unchecked_today = []
    current_user.categories.each do |category|
      category.tasks.each do |task|
        @checked_today.push(task) if task.due_date == Date.today && task.is_checked
        @unchecked_today.push(task) if task.due_date == Date.today && !task.is_checked
      end
    end
  end
end
