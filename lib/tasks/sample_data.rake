namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        User.create!(
            name:                   "fujimohige",
            email:                  "atiger7391@gmail.com",
            password:               "keep1031",
            password_confirmation:  "keep1031",
            admin:                  true
            )

        99.times do |n|
            name        = Faker::Name.name
            email       = "sample-#{n+1}@railstutorial.jp"
            password    = "password"
            User.create!(
                name:                   name,
                email:                  email,
                password:               password,
                password_confirmation:  password
                )
        end

        users = User.all.limit(6)
        50.times do
            content = Faker::Lorem.sentence(5)
            users.each do |user|
                user.microposts.create!(content: content)
            end
        end
    end
end