class User < ActiveRecord::Base

    before_save {
        self.email = email.downcase
    }

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

end
