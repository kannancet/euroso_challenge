class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :public_name
      t.string :type
      t.string :pricing_policy
      t.integer :group_organization_id
      t.integer :parent_organization_id

      t.timestamps null: false
    end
  end
end
