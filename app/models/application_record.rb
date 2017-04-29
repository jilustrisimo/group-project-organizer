class ApplicationRecord < ActiveRecord::Base
  include Orderable

  self.abstract_class = true
end
