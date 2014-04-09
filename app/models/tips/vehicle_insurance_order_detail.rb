class Tips::VehicleInsuranceOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  validates_presence_of :brand_id, :series, :plate_num, :insurance_type_id

  enumerate :insurance_type, with: %w(交强险 车上人员责任险 车损险 盗抢险 玻璃单独破碎险 不计免赔特约险 第三者责任险-5万 第三者责任险-10万 第三者责任险-20万 第三者责任险-30万 第三者责任险-50万 第三者责任险-100万)

end
