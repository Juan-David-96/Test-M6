class Post < ApplicationRecord
    belongs_to :user
    has_many :postulacions, dependent: :destroy
    has_many :users, through: :postulacions
  
    has_one_attached :image
  
    validates :titulo, presence: true
    validates :descripcion, presence: true
    validates :fecha_publicacion, presence: true
    validates :fecha_cierre, presence: true
  end
  