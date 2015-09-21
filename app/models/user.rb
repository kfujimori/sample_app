class User < ActiveRecord::Base
    # destroy user-microposts when user is destroied
    has_many :microposts,
                dependent: :destroy

    has_many :relationships,
                foreign_key: "follower_id",
                dependent: :destroy

    has_many :followed_users,
                through: :relationships,
                source: :followed

    has_many :reverse_ralationships,
                foreign_key: "followed_id",
                class_name: "Relationship",
                dependent: :destroy
    has_many :followers,
                through: :reverse_ralationships,
                source: :follower

    #############################
    # preprocessing
    #############################

    before_save {
        self.email = email.downcase
    }

    before_create :create_remember_token


    #############################
    # validation
    #############################

    # name
    validates :name,
                presence: true,
                length: {maximum: 50}

    # email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
                presence: true,
                format:     { with: VALID_EMAIL_REGEX},
                uniqueness: {case_sensitive: false}

    # defining instance variables "password","password_confirmation"
    has_secure_password
    validates :password,
                presence: true,
                length: {minimum: 6}
    validates :password_confirmation,
                presence: true,
                length: {minimum: 6}


    #############################
    # token
    #############################

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    #############################
    # feed
    #############################

    def feed
        Micropost.from_users_followed_by(self)
    end


    #############################
    # follow/followed
    #############################

    def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy
    end



    #############################
    # private
    #############################

    private

        def create_remember_token
            self.remember_token = User.encrypt(User.new_remember_token)
        end

end
