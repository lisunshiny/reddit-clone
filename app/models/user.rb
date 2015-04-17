class User < ActiveRecord::Base

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, allow_nil: true, length: { minimum: 6 }

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id

  has_many :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id

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

  def self.find_by_credentials(options = {})
    user = User.find_by(username: options[:username])
    return nil if user.nil?
    if BCrypt::Password.new(user.password_digest) == options[:password]
      user
    else
      nil
    end
  end


end
