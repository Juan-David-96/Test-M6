# Buscar y eliminar el usuario si ya existe
User.find_by(email: 'esteban@work.com')&.destroy
esteban = User.create!(
  email: 'esteban@work.com',
  password: '123456',
  password_confirmation: '123456',
  name: 'esteban',
  role: :esteban
)

# Desactivar la validación y adjuntar la imagen
#esteban.update(validate: false)
esteban.images.attach(
  io: File.open(Rails.root.join('app', 'assets', 'images', 'Estebanwork_profile.jpg')),
  filename: 'Estebanwork_profile.jpg'
)

# Verificar si la imagen fue adjuntada
puts "Esteban creado con foto: #{esteban.images.attached?}"


