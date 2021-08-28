class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    # NOT NULL制約（null: false）を追加します。NOT NULL制約とは、カラムに格納する値としてNULLを禁止します
    add_column :users, :name, :string, null: false
  end
end
