defmodule VirtaTest do
  use ExUnit.Case
  doctest Virta

  alias Virta.Node
  alias Virta.Registry
  alias Virta.EdgeData

  test "sanity" do
    adder =
      Graph.new(type: :directed)
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.Add, id: 1},
        label: %EdgeData{from: :addend, to: :addend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.Add, id: 1},
        label: %EdgeData{from: :augend, to: :augend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Math.Add, id: 1},
        %Node{module: Virta.Core.Out, id: 2},
        label: %EdgeData{from: :sum, to: :sum}
      )

    multiplier =
      Graph.new(type: :directed)
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.Multiply, id: 1},
        label: %EdgeData{from: :multiplicand, to: :multiplicand}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.Multiply, id: 1},
        label: %EdgeData{from: :multiplier, to: :multiplier}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Math.Multiply, id: 1},
        %Node{module: Virta.Core.Out, id: 2},
        label: %EdgeData{from: :product, to: :product}
      )

    complex_graph =
      Graph.new(type: :directed)
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Core.Workflow, id: 1, ref: "adder"},
        label: %EdgeData{from: :augend, to: :augend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Core.Workflow, id: 1, ref: "adder"},
        label: %EdgeData{from: :addend, to: :addend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.Workflow, id: 1, ref: "adder"},
        %Node{module: Virta.Core.Workflow, id: 2, ref: "multiplier"},
        label: %EdgeData{from: :sum, to: :multiplicand}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.Workflow, id: 1, ref: "adder"},
        %Node{module: Virta.Core.Workflow, id: 2, ref: "multiplier"},
        label: %EdgeData{from: :sum, to: :multiplier}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.Workflow, id: 2, ref: "multiplier"},
        %Node{module: Virta.Core.Out, id: 3},
        label: %EdgeData{from: :product, to: :output}
      )

    {:ok, "registered"} = Registry.register("adder", adder)
    {:ok, "registered"} = Registry.register("multiplier", multiplier)
    {:ok, "registered"} = Registry.register("complex_graph", complex_graph)

    name = "adder"

    data = %{
      %Node{module: Virta.Core.In, id: 0} => [{1, :augend, 1}, {1, :addend, 2}]
    }

    {request_id, output} = Virta.Executor.call(name, data)
    assert request_id == 1
    assert output == %{sum: 3}
  end

  test "works for stateful nodes" do
    node_configuration = %{constant: 3}
    addend = 1
    augend = 2
    adder =
      Graph.new(type: :directed)
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.ConstantAdd, id: 1,
          configuration: node_configuration},
        label: %EdgeData{from: :addend, to: :addend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Core.In, id: 0},
        %Node{module: Virta.Math.ConstantAdd, id: 1,
          configuration: node_configuration},
        label: %EdgeData{from: :augend, to: :augend}
      )
      |> Graph.add_edge(
        %Node{module: Virta.Math.ConstantAdd, id: 1,
          configuration: node_configuration},
        %Node{module: Virta.Core.Out, id: 2},
        label: %EdgeData{from: :sum, to: :sum}
      )

    data = %{
      %Node{module: Virta.Core.In, id: 0} => [{1, :augend, 1}, {1, :addend, 2}]
    }

    name = "constant_adder"
    {:ok, "registered"} = Registry.register(name, adder)
    {request_id, output} = Virta.Executor.call(name, data)
    assert output == %{sum: 6}
  end

end
