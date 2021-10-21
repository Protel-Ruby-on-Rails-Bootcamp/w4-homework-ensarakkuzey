class Comment < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :post
    belongs_to :user

    scope :accepteds, -> { where("accepted = ? OR (expire_date <= ? AND action = ?)", true, DateTime.now, false) }

    def commentter
        self.user ? user.username : ''
    end

    def status
        if DateTime.now >= expire_date
          'Expired'
        else
          'NotExpired'
        end
      end
end
