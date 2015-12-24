require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, book: { author: @book.author, author_intro: @book.author_intro, douban_url: @book.douban_url, image: @book.image, isbn: @book.isbn, jd_url: @book.jd_url, pages: @book.pages, price: @book.price, publisher: @book.publisher, stocks: @book.stocks, subtitle: @book.subtitle, summary: @book.summary, title: @book.title, translator: @book.translator }
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book
    assert_response :success
  end

  test "should update book" do
    patch :update, id: @book, book: { author: @book.author, author_intro: @book.author_intro, douban_url: @book.douban_url, image: @book.image, isbn: @book.isbn, jd_url: @book.jd_url, pages: @book.pages, price: @book.price, publisher: @book.publisher, stocks: @book.stocks, subtitle: @book.subtitle, summary: @book.summary, title: @book.title, translator: @book.translator }
    assert_redirected_to book_path(assigns(:book))
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end
end
