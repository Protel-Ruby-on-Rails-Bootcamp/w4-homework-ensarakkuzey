class Post < ApplicationRecord
    belongs_to :user

    scope :availables, -> { where(visible: true) }
end
