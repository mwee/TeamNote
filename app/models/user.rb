class User < ActiveRecord::Base
  has_many :notes, dependent: :destroy

  has_many :relationships, foreign_key: "sharer_id", dependent: :destroy
  has_many :shared_users, through: :relationships, source: :shared

  has_many :reverse_relationships, foreign_key: "shared_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :sharers, through: :reverse_relationships, source: :sharer


  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def feed
    # "Following users" feature
    Note.where("user_id = ?", id)
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def sharing?(other_user)
    relationships.find_by(shared_id: other_user.id)
  end

  def share!(other_user)
    relationships.create!(shared_id: other_user.id)
  end

  def unshare!(other_user)
    relationships.find_by(shared_id: other_user.id).destroy!
  end

  

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end