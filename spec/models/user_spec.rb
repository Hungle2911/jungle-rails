require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'Validation' do

    it 'should save user when all required fields are set correctly' do
      @user = User.new( email: 'hello@gmail.com', password: "123456", password_confirmation: "123456")
      expect(@user).to be_valid
    end

    it 'should not save if password and password_confirmation do not match' do
      @user = User.new( email: 'hello@gmail.com', password: "12345", password_confirmation: "678910")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should provide an error message if password not set' do
      @user = User.new( email: 'hello@gmail.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end


    it 'should provide an error message if email not set' do
      @user = User.new( email: nil, password: "12345hello", password_confirmation: "12345hello")
      @user.save
      # expect(@user).to_not be_valid
      # puts @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should provide an error message if email is not unique' do
      @user_1 = User.new( email: 'hello@gmail.com', password: "12345hello", password_confirmation: "12345hello")
      @user_1.save
      @user_2 = User.new( email: 'hello@gmail.com', password: "sails567", password_confirmation: "sails567")
      @user_2.save
      expect(@user_2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should have a minimun password length' do
      @user = User.new( email: 'hello@gmail.com', password: "We", password_confirmation: "We")
      @user.save
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'should only log-in user with valid credentials' do
      @user = User.new( email: 'good@aol.com', password: "12345hello", password_confirmation: "12345hello")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('good@aol.com', "12345hello")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email contains trailing spaces' do
      @user = User.new( email: 'good@aol.com', password: "12345hello", password_confirmation: "12345hello")
      @user.save
      @user_logged_in = User.authenticate_with_credentials(' good@aol.com ', "12345hello")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email in the wrong case' do
      @user = User.new( email: 'WHAT@aol.com', password: "12345hello", password_confirmation: "12345hello")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('what@aol.com', "12345hello")
      expect(@user_logged_in).to_not eq(nil)
    end
  end
end
