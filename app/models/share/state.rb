class Share::State < ActiveEnum::Base
  States = %i(unfinished finished canceled)

  value States
  
end