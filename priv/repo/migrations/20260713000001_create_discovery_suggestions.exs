defmodule Pinchflat.Repo.Migrations.CreateDiscoverySuggestions do
  use Ecto.Migration

  def change do
    create table(:discovery_suggestions) do
      add :channel_id, :text, null: false
      add :url, :text, null: false
      add :name, :text
      add :description, :text
      add :thumbnail_url, :text
      add :subscriber_count, :bigint
      add :video_count, :integer
      add :last_upload_at, :utc_datetime
      add :cluster, :text
      add :reason, :text
      add :provenance, :jsonb, null: false, default: "{}"
      add :score, :float, null: false, default: 0.0
      add :status, :text, null: false, default: "pending"
      add :scanned_at, :utc_datetime, null: false

      timestamps()
    end

    create unique_index(:discovery_suggestions, [:channel_id])
    create index(:discovery_suggestions, [:status])
    create index(:discovery_suggestions, [:score])

    alter table(:settings) do
      add :discovery_enabled, :boolean, default: false, null: false
      add :discovery_g1_enabled, :boolean, default: true, null: false
      add :discovery_g2_enabled, :boolean, default: true, null: false
      add :discovery_g3_enabled, :boolean, default: true, null: false
      add :discovery_g4_enabled, :boolean, default: true, null: false
      add :discovery_disabled_clusters, {:array, :string}, default: [], null: false
    end
  end
end
