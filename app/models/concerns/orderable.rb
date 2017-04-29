module Orderable
  extend ActiveSupport::Concern

  included do
    scope :ordered, (-> () { order(:due_date, :completed).group_by(&:completed).to_a.flatten.reject { |e| !!e == e } })
  end
end