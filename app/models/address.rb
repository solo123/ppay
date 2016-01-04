class Address < ActiveRecord::Base
  # addr_obj 这样就不用每一个拥有Address的都写一个belongs么？
  belongs_to :addr_obj, polymorphic: true
end
