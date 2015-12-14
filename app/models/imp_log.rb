class ImpLog < ActiveRecord::Base
  default_scope { order(id: :desc) }
end
