require "rails_helper"

RSpec.describe CardCommentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/card_comments").to route_to("card_comments#index")
    end

    it "routes to #new" do
      expect(get: "/card_comments/new").to route_to("card_comments#new")
    end

    it "routes to #show" do
      expect(get: "/card_comments/1").to route_to("card_comments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/card_comments/1/edit").to route_to("card_comments#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/card_comments").to route_to("card_comments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/card_comments/1").to route_to("card_comments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/card_comments/1").to route_to("card_comments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/card_comments/1").to route_to("card_comments#destroy", id: "1")
    end
  end
end
