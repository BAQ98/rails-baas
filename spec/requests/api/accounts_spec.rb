require "rails_helper"

RSpec.describe 'Api::AccountsController', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:account) { create(:auth) }

  before { sign_in account }

  describe 'GET #index' do
    context 'all accounts exist and got the correct number records per page' do
      it 'is successful' do
        get accounts_path controller: 'api/accounts#index', headers: headers
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #show' do
    context 'account exist' do
      it 'is successful' do
        get accounts_path(account.id), headers: headers
        expect(response).to be_successful
      end
    end

    context "account doesn't exist" do
      it 'is not found' do
        non_existing_id = Profile.maximum(:id).to_i + 1
        get account_path(non_existing_id), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
