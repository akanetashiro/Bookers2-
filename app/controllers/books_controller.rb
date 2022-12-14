class BooksController < ApplicationController
  
   before_action :is_matching_login_user, only: [:edit, :update]
   
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = "You have created book successfully."
      redirect_to @book
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
  end
  

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = "You have updated book successfully."
      redirect_to @book
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id]) 
    @book.destroy
    redirect_to books_path
  end
  
    private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    if(@book.user != current_user)
      redirect_to books_path
    end
  end
  
end
