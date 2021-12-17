defmodule SurfacePlaygroundWeb.Components.Meter do
  use Surface.Component

  @doc "The field name"
  prop name, :any

  @doc "Id to apply to the meter"
  prop id, :string

  @doc "Class or classes to apply to the meter"
  prop class, :css_class

  @doc """
  The label for the generated `<meter>` element, if no content (default slot) is provided.
  """
  prop label, :string

  @doc """
  Additional attributes to add onto the generated element
  """
  prop opts, :keyword, default: []

  @doc """
  The content for the field
  """
  slot default

  def render(assigns) do
    unless assigns[:default] || assigns[:label] || Keyword.get(assigns.opts, :label) do
      raise ArgumentError, "<Meters /> requires a label prop or contents in the default slot"
    end

    attr_opts = props_to_attr_opts(assigns, [:value, :min, :max, :step])

    opts =
      assigns.opts
      |> Keyword.merge(attr_opts)

    assigns = assign(assigns, opts: opts)

    ~F"""
    <meter id={@id} name={@name} :attrs={@opts}>
      <#slot>
        {@label}
      </#slot>
    </meter>
    """
  end

  defp props_to_attr_opts(assigns, opts) do
    assigns
    |> Map.get(:opts)
    |> Keyword.take(opts)
  end
end
