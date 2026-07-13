defmodule Pinchflat.Discovery.DiscoverySuggestion do
  @moduledoc """
  Schema for AI Discovery suggestions — channels surfaced by the discovery pipeline
  that the user hasn't subscribed to yet.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @allowed_fields [
    :channel_id,
    :url,
    :name,
    :description,
    :thumbnail_url,
    :subscriber_count,
    :video_count,
    :last_upload_at,
    :cluster,
    :reason,
    :provenance,
    :score,
    :status,
    :scanned_at
  ]

  @required_fields [:channel_id, :url, :scanned_at]

  schema "discovery_suggestions" do
    field :channel_id, :string
    field :url, :string
    field :name, :string
    field :description, :string
    field :thumbnail_url, :string
    field :subscriber_count, :integer
    field :video_count, :integer
    field :last_upload_at, :utc_datetime
    field :cluster, :string
    field :reason, :string
    field :provenance, :map, default: %{}
    field :score, :float, default: 0.0
    field :status, :string, default: "pending"
    field :scanned_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(suggestion, attrs) do
    suggestion
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:status, ~w(pending accepted dismissed))
    |> unique_constraint(:channel_id)
  end
end
