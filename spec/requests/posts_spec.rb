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
end
