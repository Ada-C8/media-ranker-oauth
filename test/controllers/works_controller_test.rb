require 'test_helper'

describe WorksController do
  CATEGORIES = %w(albums books movies)

  describe "index" do
    it "succeeds for a real category with many media" do
      CATEGORIES.each do |category|
        Work.by_category(category).count.must_be :>, 0, "No #{category.pluralize} in the test fixtures"
        get works_path(category)
        must_respond_with :success
      end
    end

    it "succeeds for a real category with no media" do
      Work.destroy_all
      CATEGORIES.each do |category|
        get works_path(category)
        must_respond_with :success
      end
    end

    # TODO DPR: I've yet to find a good way to test rails route constraints.
    # Whenever I attempt the test below, I get a routing exception instead of
    # a 404, even though in production a 404 is indeed rendered.
    it "renders not_found for bogus categories" do
      skip
      ["nope", "42", "", "  ", "albumstrailingtext"].each do |category|
        # Can't use a named route here b/c the route helpers are smart
        # enough to fail before we even get to the request
        get "/#{category}"
        must_respond_with :not_found
      end
    end
  end

  describe "new" do
    it "succeeds for a real category" do
      CATEGORIES.each do |category|
        get new_work_path(category)
        must_respond_with :success
      end
    end

    it "renders not_found for bogus categories" do
      skip
    end
  end

  describe "create" do
    it "creates a work with valid data for a real category" do
      work_data = {
        work: {
          title: "test work"
        }
      }
      CATEGORIES.each do |category|
        work_data[:work][:category] = category

        start_count = Work.count

        post works_path(category), params: work_data
        must_redirect_to works_path(category)

        Work.count.must_equal start_count + 1
      end
    end

    it "renders bad_request and does not update the DB for bogus data" do
      work_data = {
        work: {
          title: ""
        }
      }
      CATEGORIES.each do |category|
        work_data[:work][:category] = category

        start_count = Work.count

        post works_path(category), params: work_data
        must_respond_with :bad_request

        Work.count.must_equal start_count
      end
    end

    it "renders not_found for bogus categories" do
      skip
    end
  end

  describe "show" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end

  describe "upvote" do
  end
end
