require 'test_helper'

describe WelcomeController do
  describe "index" do
    it "succeeds with all media types" do
      # Precondition: there is at least one media of each category
      %w(album book movie).each do |category|
        Work.by_category(category).length.must_be :>, 0, "No #{category.pluralize} in the test fixtures"
      end

      get root_path
      must_respond_with :success
    end

    it "succeeds with one media type absent" do
      # Precondition: there is at least one media in two of the categories
      %w(album book).each do |category|
        Work.by_category(category).length.must_be :>, 0, "No #{category.pluralize} in the test fixtures"
      end
    end

    # Remove all movies
    Work.by_category("movie").destroy_all

    it "succeeds with no medai" do
      Work.destroy_all
      get root_path
      must_respond_with :success
    end
  end
end
