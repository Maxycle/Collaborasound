class CreateInstrumentWanteds < ActiveRecord::Migration[6.1]
  def change
    create_table :instrument_wanteds do |t|
      t.string :name

      t.timestamps
    end
  end
end
