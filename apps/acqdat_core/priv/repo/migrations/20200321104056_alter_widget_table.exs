defmodule AcqdatCore.Repo.Migrations.AlterWidgetTable do
  use Ecto.Migration

  def change do
    alter table("acqdat_widgets") do
      add(:widget_type_id, references("acqdat_widget_type", on_delete: :delete_all))
    end
  end
end
