class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum :role, [:normal_user, :author, :admin, :esteban]

  has_many_attached :images
  has_many :postulacions
  has_many :posts, through: :postulacions

  validates :images, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end

