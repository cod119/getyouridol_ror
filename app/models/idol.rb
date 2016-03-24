class Idol < ActiveRecord::Base
    default_scope { order('nameko collate "C" asc') }
end
