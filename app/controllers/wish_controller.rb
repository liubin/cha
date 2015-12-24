class WishController < ApplicationController
  def new
    @wish = Wish.new
  end

  def create
    book = Book.where(isbn: params[:isbn]).first
    if book.nil?
      render 'new', alert: '图书不存在，请先创建图书！'
    else
      wish = Wish.new do |w|
        w.user = current_user
        w.book = book
        w.status = Wish::STATUS[:DEFAULT]
      end
      if wish.save!
        redirect_to wish_list_path, alert: '图书申请已提交'
      else
        render 'new', alert: '保存图书申请失败，请重试！'
      end
    end
  end

  def all
    @wishes = Wish.all.page params[:page]
  end

  def list
    @wishes = current_user.wishes.page params[:page]
  end

  def update
    wish = Wish.find(params[:id])
    if wish.status != Wish::STATUS[:APPROVED]
      wish.status = Wish::STATUS[:APPROVED]
      wish.save!
      book = wish.book
      book.stocks = book.stocks + 1
      book.save
    end
    redirect_to wish_all_path, alert: '图书申请已更新'
  end

  def destroy
    wish = Wish.find(params[:id])
    wish.destroy
    redirect_to wish_list_path, alert: '图书申请已删除'
  end

end
