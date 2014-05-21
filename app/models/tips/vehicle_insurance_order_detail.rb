class Tips::VehicleInsuranceOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  validates_presence_of :insurance_type_ids

  InsuranceTypes = [
    "交强险",
    "车上人员责任险",
    "车辆损失险",
    "盗抢险",
    "玻璃单独破碎险",
    "不计免赔特约险",
    "自燃险",
    "新增设备损失险",
    "车身划痕险",
    "发动机损失特约险",
    "第三者责任险 - 5万",
    "第三者责任险 - 10万",
    "第三者责任险 - 20万",
    "第三者责任险 - 30万",
    "第三者责任险 - 50万",
    "第三者责任险 - 100万",
  ]
  
  serialize :insurance_type_ids, Array
  enumerate :insurance_types, with: InsuranceTypes, multiple: true
end
