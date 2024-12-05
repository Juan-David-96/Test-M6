class AddFieldsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :titulo, :string
    add_column :posts, :descripcion, :text
    add_column :posts, :fecha_publicacion, :datetime
    add_column :posts, :fecha_cierre, :datetime
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
