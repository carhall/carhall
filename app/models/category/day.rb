class Category::Day < ActiveEnum::Base
  Days = [
    "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"
  ]

  value Days

end