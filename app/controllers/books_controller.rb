# require 'open-uri'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :waiting, :borrowing]

  def transfer
    if not request.get?
    end
    # render transfer.html.slim
  end

  def waiting
    if not request.get?
      waiting = @book.waitings.where(user: current_user, book: @book).first
      if @book.waitings.include?(waiting)
        @book.waitings.destroy(waiting)
        redirect_to @book, alert: '您已经退出了等待列表'
      else
        @book.waitings.create(user: current_user)
        redirect_to @book, notice: '您已经成功加入了等待列表'
      end
    end
  end

  def borrowing
    if not request.get?
      lending = @book.lendings.where(user: current_user, book: @book).first
      if @book.lendings.include?(lending)
        @book.return lending
        redirect_to @book, alert: '您已经成功归还了本书'
      else
        if @book.stocks <= @book.lendings.count
          @book.borrow current_user
          redirect_to @book, notice: '您已经成功借阅了本书'
        else
          redirect_to @book, alert: '借阅失败，已经没库存了！'
        end
      end
    end
  end

  def isbn
    if request.get?
      # render isbbooksn.html.slim
      @book = Book.new
      return
    end

    isbn = book_params[:isbn]
    # call douban API
    response = open("https://api.douban.com/v2/book/isbn/#{isbn}").read

    @book = Book.build response

    render 'new'
  end

  # GET /books
  def index
    @books = Book.all.page params[:page]
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: '图书成功创建。' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /books/1
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: '图书成功更新。' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: '图书已经被删除。' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :subtitle, :image, :author, :translator, :pages, :douban_url, :jd_url, :publisher, :author_intro, :summary, :price, :stocks)
    end
end
