module PpwmMatcher
  class Code < ActiveRecord::Base
    self.table_name_prefix = "ppwm_matcher_"

    attr_accessible :value
  end
end
