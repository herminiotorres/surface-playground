defmodule SurfacePlaygroundWeb.Components.Button do
  use Surface.Component
  use Surface.Components.Events

  import Surface.Components.Utils

  @doc "Id to apply to the button"
  prop id, :string

  @doc "Class or classes to apply to the button"
  prop class, :css_class

  @doc """
  The label for the generated `<button>` element, if no content (default slot) is provided.
  """
  prop label, :string

  @doc """
  Additional attributes to add onto the generated element
  """
  prop opts, :keyword, default: []

  @doc """
  The content of the generated `<button>` element. If no content is provided,
  the value of property `label` is used instead.
  """
  slot default

  def render(assigns) do
    unless assigns[:default] || assigns[:label] || Keyword.get(assigns.opts, :label) do
      raise ArgumentError, "<Button /> requires a label prop or contents in the default slot"
    end

    events = events_to_opts(assigns)
    assigns = assign(assigns, opts: events ++ assigns.opts)

    ~F"""
    <button id={@id} class={@class} :attrs={@opts}><#slot>{@label}</#slot></button>
    """
  end

end
