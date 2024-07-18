class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

   def self.authenticate_with_credentials(email, password)

    @email = email.strip
    @email_lower = @email.downcase

    @user = User.find_by_email(@email_lower)

    if @user.authenticate(password)
      @user
    else
      nil
    end


  end
end
