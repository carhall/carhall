require 'spec_helper'

describe "Tips" do
  include_context "shared context"

  let(:dealer) { create :dealer, area_id: 1 }
  let(:append_attrs_when_build) {{ dealer: dealer }}

  shared_examples "tips#nearby" do 
    include_examples "resources#list", :nearby, lat: 40, lng: 116.3
  end
    
  shared_examples "tips#cheapie" do  
    include_examples "resources#list", :cheapie
  end
    
  shared_examples "tips#favorite" do  
    include_examples "resources#list", :favorite
  end
    
  shared_examples "tips#hot" do  
    include_examples "resources#list", :hot
  end

  shared_examples "tips#resources" do  
    include_examples "resources#index"

    include_examples "resources#show"
    include_examples "resources#detail"
  end

  describe Api::Tips::MendingsController do
    let(:resource) { :mending }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#favorite"
    include_examples "tips#hot"

    context "with area_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, area_id: 1 }}
      let(:args) {{ filter: { area_id: 1 }}}
      let(:other_args) {{ filter: { area_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with brand_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, brand_ids: [1] }}
      let(:args) {{ filter: { brand_id: 1 }}}
      let(:other_args) {{ filter: { brand_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with dealer_id" do
      let(:append_args) {{ dealer_id: dealer.id }}
      include_examples "resources#show"
      include_examples "resources#detail"
    end
  end

  describe Api::Tips::CleaningsController do
    let(:resource) { :cleaning }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#cheapie"
    include_examples "tips#favorite"
    include_examples "tips#hot"

    context "with area_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, area_id: 1 }}
      let(:args) {{ filter: { area_id: 1 }}}
      let(:other_args) {{ filter: { area_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with cleaning_type_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, cleaning_type_id: 1 }}
      let(:args) {{ filter: { cleaning_type_id: 1 }}}
      let(:other_args) {{ filter: { cleaning_type_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with dealer_id" do
      let(:append_args) {{ dealer_id: dealer.id }}
      include_examples "tips#resources"
      include_examples "tips#nearby"
      include_examples "tips#cheapie"
      include_examples "tips#favorite"
      include_examples "tips#hot"
    end
  end

  describe Api::Tips::ActivitiesController do
    let(:resource) { :activity }
    include_examples "tips#resources"
    include_examples "tips#nearby"

    context "with area_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, area_id: 1 }}
      let(:args) {{ filter: { area_id: 1 }}}
      let(:other_args) {{ filter: { area_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with dealer_id" do
      let(:append_args) {{ dealer_id: dealer.id }}
      include_examples "tips#resources"
      include_examples "tips#nearby"
    end
  end

  describe Api::Tips::BulkPurchasingsController do
    let(:resource) { :bulk_purchasing }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#cheapie"
    include_examples "tips#favorite"
    include_examples "tips#hot"

    context "with area_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, area_id: 1 }}
      let(:args) {{ filter: { area_id: 1 }}}
      let(:other_args) {{ filter: { area_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with bulk_purchasing_type_id" do
      let(:append_attrs_when_build) {{ dealer: dealer, bulk_purchasing_type_id: 1 }}
      let(:args) {{ filter: { bulk_purchasing_type_id: 1 }}}
      let(:other_args) {{ filter: { bulk_purchasing_type_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with dealer_id" do
      let(:append_args) {{ dealer_id: dealer.id }}
      include_examples "tips#resources"
      include_examples "tips#nearby"
      include_examples "tips#cheapie"
      include_examples "tips#favorite"
      include_examples "tips#hot"
    end
  end



  describe "Orders" do
    shared_examples "orders#use" do
      describe "PUT use" do
        include_context "create one"
        let(:args) {{ id: id }.merge(append_args) }
        include_examples "resources#put", :use
      end
    end

    shared_examples "orders#finish" do
      describe "PUT finish" do
        include_context "create one"
        let(:args) {{ id: id }.merge(append_args) }
        include_examples "resources#put", :finish
      end
    end

    shared_examples "orders#cancel" do
      describe "DELETE cancel" do
        include_context "create one"
        let(:args) {{ id: id }.merge(append_args) }
        include_examples "resources#delete", :cancel
      end
    end

    shared_examples "orders#resources" do
      let(:parent) { create parent_name, dealer: dealer }
      let(:resource) { :"#{parent_name}_order" }
      let(:append_attrs_when_build) {{ user: user, source: parent }}
      let(:append_args) {{ :"#{parent_name}_id" => parent.id }}

      include_examples "resources#index"
      include_examples "resources#show"
    end

    describe Api::Tips::OrdersController do
      describe "mending_orders" do
        let(:parent_name) { :mending }
        include_examples "orders#resources"
        include_examples "orders#finish"
        include_examples "orders#cancel"
      end

      describe "cleaning_orders" do
        let(:parent_name) { :cleaning }
        include_examples "orders#resources"
        include_examples "orders#use"
        include_examples "orders#cancel"
      end

      describe "bulk_purchasing_orders" do
        let(:parent_name) { :bulk_purchasing }
        include_examples "orders#resources"
        include_examples "orders#finish"
        include_examples "orders#cancel"
      end
    end

    describe Api::Tips::OrdersController do
      let(:append_args) {{ dealer_id: dealer.id }}
      before do
        create :mending_order, dealer: dealer, source: create(:mending, dealer: dealer)
        create :cleaning_order, dealer: dealer, source: create(:cleaning, dealer: dealer)
        create :bulk_purchasing_order, dealer: dealer, source: create(:bulk_purchasing, dealer: dealer)
      end

      include_examples "resources#collection", :index
    end
  end



  describe "Riviews" do
    let(:resource) { :review }
    let(:parent) { create parent_name, dealer: dealer }
    let(:order_name) { :"#{parent_name}_order" }
    let(:order) { create order_name, source: parent }

    shared_examples "reviews#resources" do
      let(:append_attrs_when_build) {{ order: create(order_name, source: parent) }}
      let(:append_args) {{ :"#{parent_name}_id" => parent.id }}

      include_examples "resources#index"
      include_examples "resources#show"
    end

    shared_examples "orders#review" do
      describe "POST review" do
        let(:append_args) {{ :"#{parent_name}_id" => parent.id }}
        let(:args) {{ id: order.id, data: attributes_for(:review) }.merge(append_args) }
        include_examples "resources#post", :review
      end
    end

    describe Api::Tips::ReviewsController do

      describe "mending_orders" do
        let(:parent_name) { :mending }
        include_examples "reviews#resources"
      end

      describe "cleaning_orders" do
        let(:parent_name) { :cleaning }
        include_examples "reviews#resources"
      end

      describe "bulk_purchasing_orders" do
        let(:parent_name) { :bulk_purchasing }
        include_examples "reviews#resources"
      end
    end

    describe Api::Tips::OrdersController do
      let(:order) { create order_name, user: user, source: parent }

      describe "mending_orders" do
        let(:parent_name) { :mending }
        include_examples "orders#review"
      end

      describe "cleaning_orders" do
        let(:parent_name) { :cleaning }
        include_examples "orders#review"
      end

      describe "bulk_purchasing_orders" do
        let(:parent_name) { :bulk_purchasing }
        include_examples "orders#review"
      end
    end
  end
end
