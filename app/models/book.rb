class Book < ActiveRecord::Base
  has_many :lendings
  has_many :waitings
  has_many :wishes

  validates_uniqueness_of :isbn
  validates :isbn, presence: true, length: { is: 13 }
  validates :title, presence: true, length: { maximum: 512 }
  validates :subtitle, length: { maximum: 512 }
  validates :author, presence: true, length: { maximum: 256 }
  validates :translator, length: { maximum: 256 }
  validates :douban_url, length: { maximum: 256 }
  validates :jd_url, length: { maximum: 256 }
  validates :publisher, presence: true, length: { maximum: 256 }
  validates :author_intro, presence: true, length: { maximum: 2048 }
  validates :price, presence: true, numericality: true
  validates :pages, presence: true, numericality: { only_integer: true }
  validates :stocks, presence: true, numericality: { only_integer: true }

  def return(lending)
    self.lendings.destroy(lending)
    # self.stocks = self.stocks + 1
    # self.save!
  end

  def borrow(user)
    self.lendings.create(user: user)
    # self.stocks = self.stocks - 1
    # self.save!
  end

  def self.build(response)

    dou_book = ActiveSupport::JSON.decode(response)

    return Book.new do |book|
      book.isbn = dou_book['isbn13']
      book.title = dou_book['title']
      book.subtitle = dou_book['subtitle']
      book.image = dou_book['image']
      book.author = dou_book['author'].join(',')
      book.translator = dou_book['translator'].join(',')
      book.pages = dou_book['pages']
      book.douban_url = dou_book['alt']
      book.publisher = dou_book['publisher']
      book.author_intro = dou_book['author_intro']
      book.summary = dou_book['summary']
      book.price = dou_book['price'].gsub('元','')
    end
  end
end
