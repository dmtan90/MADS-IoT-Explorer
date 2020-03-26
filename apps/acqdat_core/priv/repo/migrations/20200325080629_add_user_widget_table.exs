defmodule AcqdatCore.Repo.Migrations.AddUserWidgetTable do
  use Ecto.Migration

  def change do
    create table("acqdat_user_widgets") do
      add(:widget_id, references("acqdat_widgets", on_delete: :delete_all), null: false)
      add(:user_id, references("users", on_delete: :delete_all), null: false)
      timestamps(type: :timestamptz)
    end
    create unique_index("acqdat_user_widgets", [:widget_id, :user_id], name: :unique_widget_per_user)
  end
end
