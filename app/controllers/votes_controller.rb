class VotesController < ApplicationController
  before_action :find_micropost
  
  def create

    if already_voted?
      flash[:warning] = "You can't vote more than once"
    else
      # I know it is not safely because someone can hack database by coding in form (or somehow).
      # Does validation in model (1..5) solve this problem ?
     @vote = @micropost.votes.create(grades: params[:grades], user_id: current_user.id) 
      if @vote.save
        redirect_to root_url
      else
        flash[:warning] = "1, 2, 3, 4 or 5 only"
        redirect_to root_url
      end
    end
      
  end

    private

  # I wrote this before I created the thing that hides the form. 
  # Let keep it here yet
  def already_voted?
    Vote.where(user_id: current_user.id, micropost_id: params[:micropost_id]).exists?
  end

  def find_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
