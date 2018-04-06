require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let(:valid_attributes) {
    { institution: 'Chase', amount: 10000, active: true }
  }
  let(:invalid_attributes) {
    { institution: '', amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :index
      expect(response).to be_success
    end
  end
  
  describe "GET #show" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :show, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_success
    end
  end
  
  describe "GET #edit" do
    it "returns a success response" do
      bank_account = @user.bank_accounts.create! valid_attributes
      get :edit, params: {id: bank_account.id}
      expect(response).to be_success
    end
  end


  describe "POST #create" do
    context "with valid params" do
      
    end
    context "with invalid params" do

    end
end