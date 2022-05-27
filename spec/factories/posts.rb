FactoryBot.define do
  factory :post do
    title { "A Post Title" }
    content { "Sample post content" }
    user

    after(:create) { |post| post.user.add_role :author, post }
  end
end
