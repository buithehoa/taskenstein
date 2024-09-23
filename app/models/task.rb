class Task < ApplicationRecord
  enum :priority, [ :low, :medium, :high ], default: :low
end
