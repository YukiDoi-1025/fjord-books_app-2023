class CreateReportMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|
      t.references :mentioning, null: false, foreign_key: { to_table: :reports }
      t.references :mentioned, null: false, foreign_key: { to_table: :reports }

      t.timestamps
    end

    add_index :report_mentions, [:mentioning_id, :mentioned_id], unique: true
  end
end
