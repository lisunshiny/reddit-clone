class User < ActiveRecord::Base

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  attr_reader :password

  after_initialize :ensure_session_token

  def generate_random_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_random_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_random_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    if BCrypt::Password.new(password_digest) == password
      user
    else
      nil
    end
  end


end
