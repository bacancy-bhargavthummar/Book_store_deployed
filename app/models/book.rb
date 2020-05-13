# frozen_string_literal: true

class Book < ApplicationRecord
  before_destroy :ensure_no_line_item_is_present

  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :book_sellers, dependent: :destroy
  # has_many :users, through: :book_sellers, source: :seller
  has_many :favorites, dependent: :destroy 
  has_many :users, through: :favorites
  has_one_attached :image, dependent: :destroy
  has_many :line_items

  # VALIDATIONS
  validates :name, presence: true
  validates :description, length: {minimum: 20}
  validates :author, presence: true
  validates :price, numericality: { greater_than: 10, message: "must be greater than 10" }
  validates :isbn, numericality: true
  validates :total_qty, numericality: { only_integer: true, :greater_than => 10, message: "must be greater than 10." }

  scope :searching, ->(s) { Book.joins(:category).where('books.name LIKE ? OR books.author LIKE ? OR books.isbn LIKE ? OR categories.name LIKE ? ', "%#{s}%", "%#{s}%", "%#{s}%", "%#{s}%") }
 
  def self.validate_user(book, user)
    BookSeller.where("book_id = ? AND seller_id = ?", book.id, user.id).present? || user.admin? 
  end

  def self.user_uploads_params_graph(params, user)
    start_date = Date.parse(params[:min_date])
    end_date = Date.parse(params[:max_date])
    Book.joins(:line_items, :book_sellers).where("line_items.created_at between ? AND ? AND seller_id = ?",start_date, end_date, user.id ).group("line_items.book_id").sum(:quantity)
  end

  private

  def ensure_no_line_item_is_present
    unless line_items.empty?
      errors.add(:base, 'Book is already in line item')
      throw :abort
    end
  end
end
