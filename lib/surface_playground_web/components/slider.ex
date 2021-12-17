defmodule SurfacePlaygroundWeb.Components.Slider do
  use Surface.Component

  @doc "The type of the input"
  prop type, :any, default: "range"

  @doc "The field name"
  prop name, :any

  @doc "Id to apply to the slider"
  prop id, :string

  @doc "Class or classes to apply to the slider"
  prop class, :css_class

  @doc """
  Additional attributes to add onto the generated element
  """
  prop opts, :keyword, default: []

  def render(assigns) do
    attr_opts = props_to_attr_opts(assigns, [:value, :min, :max, :step])

    opts =
      assigns.opts
      |> Keyword.merge(attr_opts)

    assigns = assign(assigns, opts: opts)

    ~F"""
    <input :hook="Slider" type={@type} id={@id} class={@class} name={@name} :attrs={@opts}>
    """
  end

  defp props_to_attr_opts(assigns, opts) do
    assigns
    |> Map.get(:opts)
    |> Keyword.take(opts)
  end
end
