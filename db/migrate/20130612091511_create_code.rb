class CreateCode < ActiveRecord::Migration
  def up
    create_table :ppwm_matcher_codes do |t|
      t.string :value
      t.timestamps
    end
  end

  def down
    drop_table :ppwm_matcher_codes
  end
end
