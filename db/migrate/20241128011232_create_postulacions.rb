class CreatePostulacions < ActiveRecord::Migration[7.2]
  def change
    create_table :postulacions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.datetime :fecha_postulacion, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
