class ApplicationRecord < ActiveRecord::Base
  include Orderable
  include Countable
  include Checkable

  self.abstract_class = true
end
