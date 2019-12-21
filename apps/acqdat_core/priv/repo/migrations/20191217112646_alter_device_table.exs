defmodule AcqdatCore.Repo.Migrations.AlterDeviceTable do
  use Ecto.Migration

  def change do
    alter table("acqdat_devices") do
      add(:site_id, references("acqdat_sites", on_delete: :delete_all))
    end
  end
end
