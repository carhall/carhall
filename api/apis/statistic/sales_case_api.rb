module Statistic
  class SalesCaseAPI < Grape::API

    helpers do
      def parent
        current_user.sales_cases
      end
    end

    before do
      authenticate!
    end

    desc "Display all sales cases' informations of current login dealer."
    get do
      present! parent
    end

    desc "Display specified sales case's details."
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "Create a new sales case."
    params do
      requires :data do
        requires :user_mobile, type: String, desc: '客户手机号'
        requires :description, type: String, desc: '客户问题描述'
        requires :solution, type: String, desc: '推荐方案'
        requires :adviser, type: String, desc: '服务顾问'
        optional :state_id, type: Integer, desc: '状态ID：1.跟踪 2.解决 3.取消', default: 1
      end
    end
    post do
      record = parent.new(declared(params)[:data])
      if record.save
        present! record, type: :detail
      else
        failure! record
      end
    end

    desc "Search sales cases by mobile and plate_num."
    params do
      requires :query, type: String
    end
    post :search do
      status 200
      present! parent.with_query(params[:query])
    end

  end
end