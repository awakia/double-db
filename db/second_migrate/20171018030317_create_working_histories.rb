class CreateWorkingHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :working_histories do |t|
      t.references :profile
      t.string :company

      t.timestamps
    end
  end
end
