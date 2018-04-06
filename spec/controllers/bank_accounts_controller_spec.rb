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
      bank_account = FactoryBot.create(:bank_account, user: @user)
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
      #create a new account
      it "creates a new account" do
        expect {
          post :create, params: { bank_account: valid_attributes }
        }.to change(BankAccount, :count).by(1)
      end
      #redirects to path
      it "redirects to the created account" do
        post :create, params: { bank_account: valid_attributes }
        expect(response).to redirect_to(BankAccount.last)
      end
    end

    context "with invalid params" do
      # does not create a new account
      it "does not create a new account" do
      expect {
        post :create, params: { bank_account: invalid_attributes }
      }.to change(BankAccount, :count).by(0)
      end
      # returns a success response because you render a 'new' page
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { bank_account: invalid_attributes }
        expect(response).to be_success
      end
    end
  end 

  describe "PUT #update" do
    let(:new_attribute) {
      { amount: 220 }
    }

    before(:each) do
      @bank_account = FactoryBot.create(:bank_account, user: @user)
    end


    context "with valid params" do

      it "updates the requested account" do
        put :update, params: { id: @bank_account.id, bank_account: new_attribute }
        # bank_account has not yet been updated, so we need to call a new query.
        @bank_account.reload
        expect(@bank_account.amount).to eq(new_attribute[:amount])
      end

      it "redirects to account" do
        put :update, params: { id: @bank_account.id, bank_account: new_attribute }
        expect(response).to redirect_to(@bank_account)
      end
    end
    context "with invalid params" do

      it "does not update the requested account" do
        put :update, params: { id: @bank_account.id, bank_account: invalid_attributes }
        expect(@bank_account.institution).to_not eq(invalid_attributes[:institution])
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested account" do
      bank_account = @user.bank_accounts.create! valid_attributes
      expect {
        delete :destroy, params: { id: bank_account.id }
      }.to change(BankAccount, :count).by(-1)
    end
    it "redirects to the account index" do
      bank_account = @user.bank_accounts.create! valid_attributes
      delete :destroy, params: { id: bank_account.id }
      expect(response).to redirect_to(bank_accounts_url)
    end
  end
end