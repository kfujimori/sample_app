require 'spec_helper'

describe User do
    # pending "add some examples to (or delete) #{__FILE__}"

    before { @user = User.new(name:                 "test user",
                                email:              "test@email.com",
                                password:           "foobar",
                                password_confirmation:   "foobar"
    )}
    subject{ @user }

    it { should respond_to(:name)}
    it { should respond_to(:email)}
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    it { should be_valid}

    describe "when name isnt present" do
        before { @user.name = " "}
        it {should_not be_valid}
    end

    describe "when name isnt present" do
        before { @user.email = " "}
        it {should_not be_valid}
    end

    describe "when name is too ling" do
        before {@user.name = "a" * 51}
        it {should_not be_valid}
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |address|
                @user.email = address
                expect(@user).to be_valid
            end
        end
    end

    describe "when email format is invalid" do
        it "should not be valid" do
            addresses = %w[user user@ user@hoge user@. @hoge @hoge.com @ あ@hoge.com user@ほげ.com user＠hoge.com]
            addresses.each do |address|
                @user.email = address
                expect(@user).not_to be_valid
            end
        end
    end

    describe "when email address is already taken" do

        # for invalid user list
        users = nil

        before do
            user_dup = @user.dup
            user_upper = @user.dup
            user_upper.email = user_upper.email.upcase
            users = [user_dup, user_upper]

            @user.save
        end

        it "should not be valid" do
            users.each do |u|
                expect(u).not_to be_valid
            end
        end
    end

    describe "when password is not present" do
        before do
            @user = User.new(name:                  "hoge",
                                email:              "fuga@foo.com",
                                password:           " ",
                                password_confirmation:   " "
            )
        end
        it {should_not be_valid}
    end

    describe "when password doesnt match confirmation" do
        before { @user.password_confirmation = "mismatch"}
        it {should_not be_valid}
    end

    describe "with a password thats too short" do
        before { @user.password = @user.password_confirmation = "a" * 5 }
        it { should_not be_valid }
    end

    describe "return value of authenticate method" do
        before { @user.save }
        let(:found_user) { User.find_by(email: @user.email)}

        describe "with valid password" do
            it { should eq found_user.authenticate(@user.password)}
        end

        describe "with invalid password" do
            let(:user_for_invalid_password) { found_user.authenticate("invalid")}
            it { should_not eq user_for_invalid_password}
            specify { expect(user_for_invalid_password).to be_false}
        end
    end
end