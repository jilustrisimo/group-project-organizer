module Checkable
  def past_due_date?
    due_date <= Date.tomorrow && completed != true
  end
end