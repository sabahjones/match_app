class User < ActiveRecord::Base
  has_secure_password
  acts_as_mappable

  has_many :match_ones, class_name: 'Match'
  has_many :match_twos, class_name: 'Match'
  has_many :personal_messages, dependent: :destroy

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'

  has_many :user_liked, class_name: 'Like', foreign_key: 'liker_id'
  has_many :crushes, class_name:'User', through: "user_liked", source: "liked"

  has_many :user_liker, class_name: 'Like', foreign_key: 'liked_id'
  has_many :admirers, class_name:'User', through: "user_liker"


  has_one :preference, dependent: :destroy
  has_one :profile, dependent: :destroy

  has_many :pictures

  has_many :chats, :foreign_key => :sender_id

  # has_many :received_messages, class_name: 'PersonalMessage', foreign_key: 'receiver_id'
  # has_many :sent_messages, class_name: 'PersonalMessage', foreign_key: 'sender_id'

  has_many :receivers, -> { distinct }, class_name: 'User', through: 'authored_conversations'
  has_many :senders, -> { distinct }, class_name: 'User', through: 'received_conversations'

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, on: :create
  validates :zip_code, format: { with: /\A\d{5}-\d{4}|\A\d{5}\z/, :message => "should be in the form 12345 or 12345-1234" }
  # validates_date :birthday, :before => lambda { 18.years.ago }, :before_message => "must be at least 18 years old"

  scope :gender, -> (gender) { where gender: gender }
  scope :age_range, -> (min_age, max_age) {
    where("birthday <=? AND birthday >=?", find_min_birth_year(min_age), find_max_birth_year(max_age))
  }

  def self.user_location
    [lat, lng]
  end

  def self.find_min_birth_year(min_age)
    year = Date.today.year
    year = year - min_age.to_i
    Date.new(year)
  end

  def self.find_max_birth_year(max_age)
    year = Date.today.year
    year = year - max_age.to_i
    Date.new(year)
  end

  def find_age
    age = Date.today.year - self.birthday.year
    age -= 1 if Date.today < self.birthday + age.years
    return age
  end
end
