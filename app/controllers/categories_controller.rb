class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
    @today = @categories.where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
    @this_week = @categories.where(created_at: Time.current.beginning_of_week..Time.current.end_of_week)
    @this_month = @categories.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month)
  end

  # GET /categories/1 or /categories/1.json
  def show
    unless current_user.present? && @category.user == current_user
      flash[:danger] = "Unauthorized Access."
      redirect_to dashboard_path
    end
    session[:category_id] = @category.id
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Category was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title, :icon, :description)
    end
end
