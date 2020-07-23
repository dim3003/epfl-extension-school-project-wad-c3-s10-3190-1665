class Pin < ApplicationRecord
    validates :title, presence: true
    validates :tag, length: { maximum: 30 }

    belongs_to :user

    has_many :comments

    def self.most_recent
      all.order(created_at: :desc).limit(6)
    end

    def self.search(search_term)
       wildcard_filter = "%#{search_term}%"
       where('title LIKE ?', wildcard_filter).or(where('tag LIKE ?', wildcard_filter))
    end

end
