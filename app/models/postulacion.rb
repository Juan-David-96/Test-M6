class Postulacion < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :fecha_postulacion, presence: true
end
