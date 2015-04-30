class ProfileController < ApplicationController

  # GET /profile
  def show
    @profile = current_user.profile

    respond_to do |format|
      format.html
    end

  end

  # GET /profile/edit
  def edit
    @profile = current_user.profile
    
    respond_to do |format|
      format.html
    end
  end

  # PUT /profile/update
  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to '/profile', :notice => 'Profile is saved' }
      else
        format.html { render :action => 'Edit' }
      end
    end
  end

end
