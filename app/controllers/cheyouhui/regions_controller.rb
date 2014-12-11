class Cheyouhui::RegionsController < ApplicationController

   set_resource_class Cheyouhui::Region

  def managers
  	 @managers = Accounts::Club.where("region_id is not null")
  end

  def accept
  	account = Accounts::Club.find params[:user_id]
  	if account.accepted?
  		account.reject!
  	else
  		account.accept!
  	end
  	
    flash
    redirect_to :back
  end

  def self.set_resource_class klass, options={}
    super klass, options.reverse_merge(title: :name)
  end

  def cheyouhui_region_params
    params.require(:cheyouhui_region).permit(:name)
  end
  

 
end
