class Idol < ActiveRecord::Base
    def self.search(name)
        where('nameko LIKE :name OR LOWER(nameen) LIKE :name OR nameja LIKE :name', name: "%#{name.downcase}%")
    end
end
