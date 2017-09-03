class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
      validates :name, presence: true, uniqueness: true	
  has_many :posts
  validates :name ,presence: true , length: {maximum: 10 , minimum: 2}
  validates :intro , length: {maximum: 50}
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followed_id

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :following

  has_many :comments

  def followed_by?(user)
      passive_relationships.find_by(following_id: user.id).present?
  end
end
