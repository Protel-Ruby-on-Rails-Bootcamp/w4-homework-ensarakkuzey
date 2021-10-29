class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    belongs_to :user
    has_many :bookmarks, dependent: :destroy
    has_many :comments, dependent: :destroy

    scope :availables, -> { where(visible: true) }

    def reading_time
        words_per_minute = 150
        text = Nokogiri::HTML(self.content).at('body').inner_text
        (text.scan(/\w+/).length / words_per_minute).to_i + 1
    end
end
