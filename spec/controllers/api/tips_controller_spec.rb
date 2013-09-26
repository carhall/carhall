require 'spec_helper'

describe "Tips" do
  include_context "shared context"
  let(:dealer) { create :dealer }
  let(:attach_attrs) {{ dealer: dealer }}

  shared_examples "tips#nearby" do  
    describe "GET nearby" do
      let(:default_args) {{ lat: 40, lng: 116.3 }}
      let(:collection_name) { :nearby }
      include_examples "resources#collection"
    end
  end
    
  shared_examples "tips#cheapie" do  
    describe "GET cheapie" do
      let(:collection_name) { :cheapie }
      include_examples "resources#collection"
    end
  end
    
  shared_examples "tips#favorite" do  
    describe "GET favorite" do
      let(:collection_name) { :favorite }
      include_examples "resources#collection"
    end
  end
    
  shared_examples "tips#hot" do  
    describe "GET hot" do
      let(:collection_name) { :hot }
      include_examples "resources#collection"
    end
  end

  shared_examples "tips#resources" do  
    include_examples "resources#index"

    include_examples "resources#show"
    include_examples "resources#detail"
  end

  describe Api::Tips::MendingsController do
    let(:resource_name) { :mending }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#favorite"
    include_examples "tips#hot"
  end

  describe Api::Tips::CleaningsController do
    let(:resource_name) { :cleaning }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#cheapie"
    include_examples "tips#favorite"
    include_examples "tips#hot"

    context "with cleaning_type_id" do
      let(:attach_attrs) {{ cleaning_type_id: 1 }}
      let(:filter_args) {{ filter: { cleaning_type_id: 1 }}}
      let(:empty_filter_args) {{ filter: { cleaning_type_id: 2 }}}
      include_examples "resources#index filter"
    end
  end

  describe Api::Tips::ActivitiesController do
    let(:resource_name) { :activity }
    include_examples "tips#resources"
    include_examples "tips#nearby"
  end

  describe Api::Tips::BulkPurchasingsController do
    let(:resource_name) { :bulk_purchasing }
    include_examples "tips#resources"
    include_examples "tips#nearby"
    include_examples "tips#cheapie"
    include_examples "tips#favorite"
    include_examples "tips#hot"

    context "with bulk_purchasing_type_id" do
      let(:attach_attrs) {{ bulk_purchasing_type_id: 1 }}
      let(:filter_args) {{ filter: { bulk_purchasing_type_id: 1 }}}
      let(:empty_filter_args) {{ filter: { bulk_purchasing_type_id: 2 }}}
      include_examples "resources#index filter"
    end
  end

  describe "Orders" do
    shared_examples "orders#use" do
      describe "PUT use" do
        let(:put_name) { :use }
        let(:default_args) {{ id: id }}
        include_examples "resources#put"
      end
    end

    shared_examples "orders#finish" do
      describe "PUT finish" do
        let(:put_name) { :finish }
        let(:default_args) {{ id: id }}
        include_examples "resources#put"
      end
    end

    shared_examples "orders#cancel" do
      describe "DELETE cancel" do
        let(:delete_name) { :cancel }
        let(:default_args) {{ id: id }}
        include_examples "resources#delete"
      end
    end

    shared_examples "orders#resources" do
      let(:parent) { create parent_name, dealer: dealer }
      let(:resource_name) { :"#{parent_name}_order" }
      let(:attach_attrs) {{ user: user, source: parent }}
      let(:attach_args) {{ :"#{parent_name}_id" => parent.id }}

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

    describe Api::OrdersController do
      let(:attach_args) {{ dealer_id: dealer.id }}
      before do
        create :mending_order, dealer: dealer, source: create(:mending, dealer: dealer)
        create :cleaning_order, dealer: dealer, source: create(:cleaning, dealer: dealer)
        create :bulk_purchasing_order, dealer: dealer, source: create(:bulk_purchasing, dealer: dealer)
      end

      include_examples "resources#index base"
    end
  end

  describe "Riviews" do
    let(:resource_name) { :review }
    let(:parent) { create parent_name, dealer: dealer }
    let(:order_name) { :"#{parent_name}_order" }
    let(:order) { create order_name, source: parent }

    shared_examples "reviews#resources" do
      let(:attach_attrs) {{ order: order }}
      let(:attach_args) {{ :"#{parent_name}_id" => parent.id }}
      before { 3.times { create :review, order: create(order_name, source: parent) } }

      include_examples "resources#index base"
      include_examples "resources#show"
    end

    shared_examples "orders#review" do
      describe "POST review" do
        let(:attach_args) {{ :"#{parent_name}_id" => parent.id }}

        let(:post_name) { :review }
        let(:default_args) {{ id: order.id, data: attributes_for(:review) }}
        include_examples "resources#post"
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
