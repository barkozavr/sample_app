class VotesController < ApplicationController
    # finding micropost that we will grade before we will grade
  before_action :find_micropost
  
  # create one grade on "Like"-system. I am try using like-system because it more easy. 
  # I just try to make MVC work, after that way to votes-system
  def create
    @micropost.votes.create(user_id: current_user.id)
    redirect_to root_url #will change it later
  end

    private

  # is it correct? 
  def find_micropost
    @micropost = Micropost.find(params[:id])
  end

end
