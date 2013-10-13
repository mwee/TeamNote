class NotesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:show, :destroy, :edit, :update]
  
  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = "Note created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
  end

  def update
    @note = current_user.notes.find(params[:id])
    if @note.update_attributes(note_params)
      redirect_to root_url
    else
      render 'edit'
    end

  end

  def show
  end


  def destroy
    @note.destroy
    redirect_to root_url
  end

  private

    def note_params
      params.require(:note).permit(:content)
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      if @note.user_id != current_user.id
        flash[:notice] = "You don't have the permissions to view this note."
        redirect_to root_url 
      
      end
      redirect_to root_url if @note.nil?
    end
end