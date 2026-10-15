# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

existing_users = User.all

existing_users.each do |user|
  # প্রতিটি ইউজার ৩টি করে পোস্ট তৈরি করবে
  3.times do
    post = user.posts.create!(
      title: Faker::Lorem.sentence(word_count: 5),
      description: Faker::Lorem.paragraphs(number: 3).join("\n\n")
    )

    # পোস্টে র্যান্ডম অন্য ইউজাররা কমেন্ট করবে
    rand(2..4).times do
      commenter = existing_users.sample # যেকোনো ইউজার কমেন্ট করতে পারে

      post.comments.create!(
        user: commenter,
        statement: Faker::Lorem.paragraph(sentence_count: 2) # Schema অনুযায়ী column name মিলিয়ে নেবেন
      )
    end
  end
end
