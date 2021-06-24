class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.text :comment

      t.timestamps
    end
  end
end
