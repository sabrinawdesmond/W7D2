class User < ApplicationRecord

  before_validation :ensure_session_token

  attr_reader :password

  F self.find_by_credentials
  I is_password?
  G generate_unique_user_token
  V validations
  A attr_reader :password 
  P password/password=
  E ensure_session_token
  R reset_session_token!

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    bcrypt_obj = BCrypt::Password.new(self.password_digest)
    bcrypt_obj.is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_unique_user_token
    self.save!
    self.session_token
  end

  private

  def generate_unique_user_token
    token = SecureRandom::urlsafe_base64
    while User.exists?(session_token: token)
      token = SecureRandom::urlsafe_base64
    end
    token
  end

  def ensure_session_token
    self.session_token ||= generate_unique_user_token
  end


end
