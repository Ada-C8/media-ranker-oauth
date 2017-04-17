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

  describe "login_form" do
    # The login form is a static page - no real way to make it fail
    it "succeeds" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    # This functionality is complex!
    # There are definitely interesting cases I haven't covered
    # here, but these are the cases I could think of that are
    # likely to occur. More test cases will be added as bugs
    # are uncovered.
    #
    # Note also: some more behavior is covered in the upvote tests
    # under the works controller, since that's the only place
    # where there's an interesting difference between a logged-in
    # and not-logged-in user.
    it "succeeds for a new user" do
      username = "test_user"
      # Precondition: no user with this username exists
      User.find_by(username: username).must_be_nil

      post login_path, params: { username: username }
      must_redirect_to root_path
    end

    it "succeeds for a returning user" do
      username = User.first.username
      post login_path, params: { username: username }
      must_redirect_to root_path
    end

    it "renders 400 bad_request if the username is blank" do
      post login_path, params: { username: "" }
      must_respond_with :bad_request
    end

    it "succeeds if a different user is already logged in" do
      username = "user_1"
      post login_path, params: { username: username }
      must_redirect_to root_path

      username = "user_2"
      post login_path, params: { username: username }
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "succeeds if the user is logged in" do
      # Gotta be logged in first
      post login_path, params: { username: "test user" }
      must_redirect_to root_path

      post logout_path
      must_redirect_to root_path
    end

    it "succeeds if the user is not logged in" do
      post logout_path
      must_redirect_to root_path
    end
  end
end
