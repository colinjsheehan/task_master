class Task < ActiveRecord::Base
    belongs_to :user
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
# <! ------------------------>
    validates :user_id, presence: true
# <! ------------------------>
    validates :due_date, presence: true
end
