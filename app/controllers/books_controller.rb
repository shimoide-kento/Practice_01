class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit]
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:complete] = "Book was successfully created"
      redirect_to book_path(@book)
    else
      @user = current_user
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:complete] = "Book was successfully updated"
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destory
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_book
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end



end
