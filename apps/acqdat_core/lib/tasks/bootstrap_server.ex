defmodule Mix.Tasks.Bootstrap do
  use Mix.Task

  def run(args) do
    Application.put_env(:phoenix, :serve_endpoints, true, persistent: true)
    Mix.Tasks.Run.run run_args() ++ args

    case Application.ensure_all_started(:acqdat_api) do
       {:ok, _} ->
        File.touch!("/tmp/app-initialized", 1544519753)
       _error -> raise "Unable to start..."
    end
  end

  defp run_args do
    if iex_running?(), do: [], else: ["--no-halt"]
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?
  end

end
