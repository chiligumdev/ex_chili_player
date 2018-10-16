# Files to Help in requests
defmodule Player do

  defmacro __using__(_) do
    quote do
      @player_api_url "https://player.chiligumvideos.com/api/videos/"

      @doc """
      Returns a collection of videos belonging to the owner of the informed token

      ## Example

          iex> ChiliPlayer.videos([token: 'my_awesome_token'])
          {200,
           %{
             activated: true,
             created_at: "2018-10-15T17:41:08.874-03:00",
             data: "https://s3.amazonaws.com/awesome_video_url.mp4",
             id: 5350,
             player_url: "https://player.chiligumvideos.com/awesome_player_url",
             postback_url: nil,
             preserve_original_file: true,
             teaser_id: nil,
             wartermark_start: nil,
             watermark_duration: nil,
             watermark_image_url: nil,
             watermark_link: nil,
             watermark_position: nil
           }}

      """
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

      def upload(options \\ %{}, headers \\ []) do
        params = %{"video" => options}
        {:ok, body} =  Poison.encode params
        @player_api_url
        |> HTTPoison.post(body, headers)
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

      def update(video_id, options \\ %{}, headers \\ []) do
        params = %{"video" => options}
        {:ok, body} = Poison.encode params
        @player_api_url <> to_string(video_id)
        |> HTTPoison.patch(body, headers)
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

      def delete(video_id, headers \\ []) do
        @player_api_url <> to_string(video_id)
        |> HTTPoison.delete(headers)
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
    end
  end
end
