class Pin < ApplicationRecord

    has_and_belongs_to_many :users

    def self.most_recent
      all.order(created_at: :desc).limit(6)
    end

end
