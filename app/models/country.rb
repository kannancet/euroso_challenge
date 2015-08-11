class Country < ActiveRecord::Base

	has_many :group_organizations, dependent: :destroy
end
