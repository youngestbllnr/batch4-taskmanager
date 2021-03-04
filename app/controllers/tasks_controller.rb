class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @today = @tasks.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
    @this_week = @tasks.where(created_at: Time.current.beginning_of_week..Time.current.end_of_week)
    @this_month = @tasks.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    if session[:category_id].present? && Category.find(session[:category_id]).present?
      @category = Category.find(session[:category_id]) 
      @task.category = @category
    elsif session[:category_id].nil?
      redirect_to dashboard_path, notice: "Session expired."
    else
      redirect_to dashboard_path, notice: "Category does not exist."
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to category_path(@task.category, anchor: "task_#{ @task.id }"), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to category_path(@task.category, anchor: "task_#{ @task.id }"), notice: "Task was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :is_checked)
    end
end
