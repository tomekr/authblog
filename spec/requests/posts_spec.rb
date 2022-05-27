require "rails_helper"

RSpec.describe "Posts", :type => :request do
  let!(:user) { create(:user) }
  before(:each) { sign_in(user) }

  it "creates a post" do
    post posts_path, :params => { :post => {:title => "A post title", content: "Sample post content"} }

    expect(response).to redirect_to(assigns(:post))
    follow_redirect!

    expect(response.body).to include("Post was successfully created.")
    expect(response.body).to include("A post title")
    expect(response.body).to include("Sample post content")
  end

  it "assigns the author role to the post" do
    post posts_path, :params => { :post => {:title => "A post title", content: "Sample post content"} }
    expect(assigns(:post).authors).to contain_exactly(user)
  end

  it "doesn't allow a user that isn't an author to update a post" do
    post = create(:post, user: user, title: "Original Title", content: "Original content")
    other_user = create(:user, email: "other_user@example.com")
    sign_in(other_user)

    patch post_path(post), :params => { :post => {:title => "A New Post Title", content: "New post content"} }
    follow_redirect!
    expect(response.body).not_to include("A New Post Title")
    expect(response.body).not_to include("New post content")
    expect(response.body).to include("You are not authorized to perform this action")
  end

  it "allows an author to update a post" do
    post = create(:post, user: user, title: "Original Title", content: "Original content")

    patch post_path(post), :params => { :post => {:title => "A New Post Title", content: "New post content"} }
    follow_redirect!

    expect(response.body).to include("A New Post Title")
    expect(response.body).to include("New post content")
  end

  it "doesn't allow a user that is an author of another post to update another users post" do
    post = create(:post, user: user, title: "Original Title", content: "Original content")
    other_user = create(:user, email: "other_user@example.com")
    sign_in(other_user)
    create(:post, user: other_user, title: "A Different Post", content: "Different content")

    patch post_path(post), :params => { :post => {:title => "A New Post Title", content: "New post content"} }
    follow_redirect!

    expect(response.body).not_to include("A New Post Title")
    expect(response.body).not_to include("New post content")
    expect(response.body).to include("You are not authorized to perform this action")
  end
end
