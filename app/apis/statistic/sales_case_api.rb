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
        optional :user_brand, type: String, desc: '车型'
        requires :user_plate_num, type: String, desc: '车牌号'
        requires :project, type: String, desc: '施工项目'
        optional :operator, type: String, desc: '施工人员'
        optional :inspector, type: String, desc: '质检员'
        requires :adviser, type: String, desc: '服务顾问'      
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

  end
end