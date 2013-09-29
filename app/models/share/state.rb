class Share::State < ActiveEnum::Base
  States = %i(finished canceled)

  value States
  
end