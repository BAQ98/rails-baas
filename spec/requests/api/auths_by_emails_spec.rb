# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Api::AuthsByEmails", type: :request do
  describe "GET show" do
    let(:headers) do
      { "ACCEPT" => "application/json" }
    end

    context "auths exist" do
      it "is successful" do
        auth = create(:auth)
        get api_auths_by_email_path(email: auth.email), headers: headers
        expect(response).to be_successful
      end
    end

    context "auths dont exist" do
      it "is not found" do
        get api_auths_by_email_path(email: "junk@example.com"), headers: headers
        expect(response.status).to eq 404
      end
    end
  end
end
