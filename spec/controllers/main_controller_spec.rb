require 'rails_helper'

RSpec.describe MainController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:checked_task) { create(:task, :checked, category: category) }
  let!(:unchecked_task) { create(:task, :unchecked, category: category) }
  let!(:checked_today) { create(:task, :today, :checked, category: category) }
  let!(:unchecked_today) { create(:task, :today, :unchecked, category: category) }

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "redirects to dashboard when current_user is present" do
      sign_in(user)

      get :index
      expect(response).to redirect_to('/dashboard')
    end
  end

  describe "GET dashboard" do
    it "renders the dashboard template when current_user is present" do
      sign_in(user)

      get :dashboard
      expect(response).to render_template(:dashboard)
    end

    it "assigns @categories" do
      sign_in(user)

      get :dashboard
      expect(assigns(:categories)).to eq([category])
    end

    it "redirects to login when current_user is NOT present" do
      get :dashboard
      expect(response).to redirect_to('/login')
    end
  end

  describe "GET today" do
    it "renders the today template when current_user is present" do
      sign_in(user)

      get :today
      expect(response).to render_template(:today)
    end

    it "assigns @checked_today" do
      sign_in(user)

      get :today
      expect(assigns(:checked_today)).to eq([checked_today])
    end

    it "assigns @unchecked_today" do
      sign_in(user)
  
      get :today
      expect(assigns(:unchecked_today)).to eq([unchecked_today])
    end

    it "redirects to login when current_user is NOT present" do
      get :today
      expect(response).to redirect_to('/login')
    end
  end
end