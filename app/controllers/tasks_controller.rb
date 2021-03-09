class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /tasks/1 or /tasks/1.json
  def show
    unless current_user.present? && @task.category.user == current_user
      flash[:danger] = "Unauthorized Access."
      redirect_to dashboard_path
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @category = Category.find(params[:category_id])
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    if params[:category_id].present? && Category.find(params[:category_id]).present?
      @category = Category.find(params[:category_id]) 
      @task.category = @category
    elsif params[:category_id].nil?
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
        format.html { redirect_to category_task_path(@task, category_id: @task.category_id), notice: "Task was successfully updated." }
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

  # TOGGLE STATUS /toggle-task
  def toggle_status
      task = Task.find(params[:task_id])
      if task.category.user == current_user
        task.toggle!(:is_checked)
        if params[:ref] == "today"
            redirect_to today_path(anchor: "task_#{ task.id }")
        elsif params[:ref] == "category"
            redirect_to category_path(task.category, anchor: "task_#{ task.id }")
        else
            redirect_to category_task_path(task, category_id: task.category_id)
        end
      else
        flash[:danger] = "Unauthorized Access."
        redirect_to dashboard_path
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
      @category = Category.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :is_checked)
    end
end
