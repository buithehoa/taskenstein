class Task < ApplicationRecord
  PRIORITY_LABELS = { low: 'Low Priority', medium: 'Medium Priority', high: 'High Priority' }

  enum :priority, [ :low, :medium, :high ], default: :low

  validates_presence_of :title
end
