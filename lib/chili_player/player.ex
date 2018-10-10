# Files to Help in requests
defmodule ChiliPlayer.Player do

  @player_api_url "https://player.chiligumvideos.com/api/videos/"

  def videos(headers \\ []) do
    @player_api_url
    |> HTTPoison.get(headers)
    |> case do
        {:ok, %{body: raw, status_code: code }} -> {code, raw}
        {:error, %{reason: reason}} -> {:error, reason}
      end
    |> (fn {ok, body} ->
          body
          |> Poison.decode(keys: :atoms)
          |> case do
            {:ok, parsed} -> {ok, parsed}
            _ -> {:error, body}
          end
       end).()
  end

  def video(video_id, headers \\ []) do
    @player_api_url <> to_string(video_id)
    |> HTTPoison.get(headers)
    |> case do
        {:ok, %{body: raw, status_code: code}} -> {code, raw}
        {:error, %{reason: reason}} -> {:error, reason}
      end
    |> (fn {ok, body} ->
        body
        |> Poison.decode(keys: :atoms)
        |> case do
           {:ok, parsed} -> {ok, parsed}
           _ -> {:error, body}
        end
    end).()
  end
end
