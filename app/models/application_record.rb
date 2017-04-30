class ApplicationRecord < ActiveRecord::Base
  include Orderable
  include Countable

  self.abstract_class = true
end
