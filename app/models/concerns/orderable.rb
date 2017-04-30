module Orderable
  extend ActiveSupport::Concern

  included do
    scope :ordered, (-> () { order(:completed, :due_date).group_by(&:completed).to_a.flatten.reject { |e| !!e == e } })
  end
end