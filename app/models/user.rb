class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article
  has_many :comments

  validates :name, presence: true
  validates :profile, length: { maximum: 160 }

  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end

  def articles
    return Article.where(user_id: self.id)
  end

  mount_uploader :imagename, ImagenameUploader
end
