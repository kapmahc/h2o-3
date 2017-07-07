class Mall::Variant < ApplicationRecord
  monetize :price_cents
  monetize :cost_cents
end
