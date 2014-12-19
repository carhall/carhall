class Cheyouhui::Business::DealersController < ApplicationController
	before_filter :dealers_from_region

  def index
  	#ids = @dealers.map(&:id)
  	#@free_tickets=::Tips::FreeTicket.where("dealer_id in (?)", ids).count
  	#@bulk_purchasings = ::Tips::BulkPurchasing.in_progress.where("dealer_id in (?)",ids).count
  	#@cleanings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=1 and dealer_id in (?)",ids).count 
  	#@mendings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=5 and dealer_id in (?)",ids) 
  end

  def  free_tickets
  #	binding.pry
  	@free_tickets=::Tips::FreeTicket.in_progress.where("dealer_id in(?)",@dealers.map(&:id))
  end

  def groupons
  	@bulk_purchasings = ::Tips::BulkPurchasing.in_progress.where("dealer_id in(?)",@dealers.map(&:id))
  end

  def cleanings
  	 type = params["type"]=="mending" ? "mending" : "cleaning"
  	 @cleanings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=1 and dealer_id in(?)",@dealers.map(&:id)) if type=="cleaning"
  	 @cleanings = ::Tips::Cleaning.where("is_cheyouhui=1 and cleaning_type_id=5 and dealer_id in(?)",@dealers.map(&:id)) if type=="mending"
  end

  def orders
  end

  private

  def dealers_from_region
   	  region_id = @user.region_id || Cheyouhui::Region.first.id
   	  @dealers = Accounts::Dealer.where("region_id=?",region_id)

   end

end
