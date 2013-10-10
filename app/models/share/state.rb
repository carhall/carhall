class Share::State < ActiveEnum::Base
  States = %i(finished canceled unfinished)

  value States
  
end