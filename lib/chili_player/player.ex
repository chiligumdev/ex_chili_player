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
           [
             %{
               activated: true,
               created_at: "2018-10-16T14:38:42.236-03:00",
               data: "https://s3.amazonaws.com/awesome_video_url.mp4",
               id: 1234,
               player_url: "https://player.chiligumvideos.com/awesome_player_url",
               postback_url: nil,
               preserve_original_file: true,
               teaser_id: nil,
               wartermark_start: nil,
               watermark_duration: nil,
               watermark_image_url: nil,
               watermark_link: nil,
               watermark_position: nil
             },
             %{
               activated: true,
               created_at: "2018-10-15T19:37:11.418-03:00",
               data: "https://s3.amazonaws.com/awesome_video_url.mp4",
               id: 5678,
               player_url: "https://player.chiligumvideos.com/awesome_player_url",
               postback_url: nil,
               preserve_original_file: true,
               teaser_id: nil,
               wartermark_start: "",
               watermark_duration: "",
               watermark_image_url: "",
               watermark_link: "",
               watermark_position: "center"
             }
           ]}


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

      @doc """
      Returns a especific video belonging to the owner of the informed token passing
      the video_id parameter

      ## Example

          iex> ChiliPlayer.videos(1234, [token: 'my_awesome_token'])
          {200,
           %{
             activated: true,
             created_at: "2018-10-15T17:41:08.874-03:00",
             data: "https://s3.amazonaws.com/awesome_video_url.mp4",
             id: 1234,
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

      @doc """
      Send a POST request with options map with data to upload videos in Chiligum Player Api.
      Its mandatory send headers with a valid token information.

      ## Example
          iex> ChiliPlayer.upload(%{data: "https://s3.amazonaws.com/my_owesome_video.mp4", name: "My Owesome Video", preserve_original_file: false}, [token: "dc85c040556c5dc46f498cf8", "Content-Type": "application/json"])

          {200,
           %{
             activated: true,
             created_at: "2018-10-16T14:59:41.287-03:00",
             data: "https://s3.amazonaws.com/my_owesome_video.mp4",
             id: 1234,
             player_url: "https://player.chiligumvideos.com/awesome_player",
             postback_url: nil,
             preserve_original_file: false,
             teaser_id: nil,
             wartermark_start: nil,
             watermark_duration: nil,
             watermark_image_url: nil,
             watermark_link: nil,
             watermark_position: nil
           }}

      """
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

      @doc """
      To update the video it is necessary to inform the video id and a Map options with the information such as name, postback_url, preserve_original_file, activated, watermark_image_url, watermark_link, watermark_position, wartermark_start, watermark_duration and in the headers parameter a valid token

      ## Example
          iex> ChiliPlayer.update(1234, %{name: "new name video, preserve_original_file: false"}, [token: "my_owesome_token"])
          {200,
           %{
             activated: true,
             created_at: "2018-10-15T17:58:23.608-03:00",
             data: "https://s3.amazonaws.com/my_owesome_video.mp4",
             id: 1234,
             player_url: "https://player.chiligumvideos.com/awesome_player",
             postback_url: nil,
             preserve_original_file: false,
             teaser_id: nil,
             wartermark_start: nil,
             watermark_duration: nil,
             watermark_image_url: nil,
             watermark_link: nil,
             watermark_position: nil
           }}
      """
      def update(video_id, options \\ %{}, headers \\ []) do
        params = %{"video" => options}
        {:ok, body} = Poison.encode(params)
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

      @doc """
      To delete a video simply call the delete function passing the video id and also a token of a valid account

      ## Example

          iex> ChiliPlayer.delete(1234, [token: "my_awesome_token"])

          {200, %{msg: "deleted"}}
      """
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
