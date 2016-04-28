class CommonPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
    @contact = Contact.new
  end

  def contact_create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Post Message!!"
      redirect_to :back
    else
      render 'contact'
    end
  end

  private
  
  def contact_params 
    params.require(:contact).permit(:name, :email, :message)
  end
end
