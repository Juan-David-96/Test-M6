require "test_helper"

class PostulacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @normal_user = users(:one)
    @admin_user = users(:two)
    @esteban_user = users(:three)
    @post = posts(:one)
    sign_in @esteban_user
    post posts_path, params: { post: { titulo: 'Nueva Oferta', descripcion: 'Descripción de la oferta' } }
    @post = Post.last
  end

  test "un usuario se postula correctamente a una oferta" do
    sign_in @normal_user
    get post_path(@post)
    assert_response :success
    assert_select "h1", text: @post.titulo
    post post_postulacions_path(@post), params: { postulacion: { fecha_postulacion: Time.current } }
    assert_redirected_to @post
    follow_redirect!
    assert_text "Te has postulado exitosamente."
    assert_text @normal_user.name
  end

  test "un usuario elimina su postulación" do
    sign_in @normal_user
    post post_postulacions_path(@post), params: { postulacion: { fecha_postulacion: Time.current } }
    assert_redirected_to @post
    follow_redirect!
    assert_text "Te has postulado exitosamente."
    postulacion = @post.postulacions.find_by(user: @normal_user)
    delete post_postulacion_path(@post, postulacion)
    assert_redirected_to @post
    follow_redirect!
    assert_text "Postulación eliminada exitosamente."
    assert_no_text @normal_user.name
  end

  test "un usuario no puede crear un post si no es Esteban" do
    sign_in @normal_user
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { titulo: 'Post no permitido', descripcion: 'Descripción no permitida' } }
    end
    assert_redirected_to root_path
  end

  test "Esteban puede crear un post" do
    sign_in @esteban_user
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { titulo: 'Nuevo Post de Esteban', descripcion: 'Descripción del nuevo post' } }
    end
    assert_redirected_to post_path(Post.last)
  end
end
