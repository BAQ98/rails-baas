require "rails_helper"

RSpec.describe Pagination, type: :controller do
  controller(ApplicationController) do
    include Pagination
  end

  let(:records) { (1..30).to_a }

  describe "#default_per_page" do
    it "returns the default per page value" do
      expect(controller.default_per_page).to eq(5)
    end
  end

  describe "#page_num" do
    context "when :page parameter present" do
      it "returns the value of the page num" do
        controller.params[:page] = "2"
        expect(controller.page_no).to eq (2)
      end
    end

    context "when :page parameter do not present" do
      it "returns the default value (equal to 1) of the page num" do
        expect(controller.page_no).to eq (1)
      end
    end
  end

  describe "#per_page" do
    context "when :per_page parameter present" do
      it "returns the value of the per page" do
        controller.params[:per_page] = "10"
        expect(controller.per_page).to eq (10)
      end
    end

    context "when :per_page parameter do not present" do
      it "returns the value of the default per page (5)" do
        expect(controller.per_page).to eq (5)
      end
    end
  end

  describe "#paginate_offset" do
    context "calculates the correct offset based on page number and per page value" do
      it "calcs correctly" do
        controller.params[:page] = "3"
        controller.params[:per_page] = "10"
        expect(controller.paginate_offset).to eq (20)
      end
    end
  end

  describe "#total_pages" do
    context "calculates the correct total pages based on per page value" do
      it "get all accounts" do
        controller.params[:per_page] = "5"
        expect(controller.total_pages(records)).to eq (records.count.to_f / controller.per_page).ceil
      end
    end
  end
end
