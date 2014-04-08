module Statistic
  class SalesCaseAPI < Grape::API

    helpers do
      def parent
        current_user.sales_cases.includes(user: [:detail])
      end
    end

    before do
      authenticate!
    end

    desc "显示当前登录商户的所有销售跟踪记录"
    get do
      present! parent
    end

    desc "显示指定销售跟踪记录详情"
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "新建一条销售跟踪记录"
    params do
      requires :data do
        requires :user_id, type: Integer, desc: '客户ID'
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

    desc "编辑一条销售跟踪记录"
    params do
      requires :data do
        requires :user_id, type: Integer, desc: '客户ID'
        requires :description, type: String, desc: '客户问题描述'
        requires :solution, type: String, desc: '推荐方案'
        requires :adviser, type: String, desc: '服务顾问'
        optional :state_id, type: Integer, desc: '状态ID：1.跟踪 2.解决 3.取消', default: 1
      end
    end
    put ":id" do
      record = parent.find(params[:id])
      record.update(declared(params)[:data])
      if record.save
        present! record, type: :detail
      else
        failure! record
      end
    end

    desc "通过手机号或车牌号搜索销售跟踪记录"
    params do
      requires :query, type: String, desc: '手机号或车牌号'
    end
    post :search do
      status 200
      json = {}
      user = Accounts::User.with_query(params[:query]).first
      sales_cases = parent.with_user(user)
      json[:sales_cases] = Statistic::SalesCaseEntity.represent(sales_cases)
      json[:user_info] = Statistic::UserInfoEntity.represent(user)
      json
    end

  end
end