# ChiliPlayer
Lib to easily call [Chili Player API](https://player.chiligumvideos.com/)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `chili_player` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chili_player, "~> 0.1.0"}
  ]
end
```

and run $ mix deps.get


## Usage

First of all, you need to sign in [chili player](https://player.chiligumvideos.com/) and then you need to get your credential.

Once you get the token, just send it inside the header parameter in all the requisitions to authenticate the user. Let's see in practice how it works in the examples below.

## Videos


### List all videos

    ChiliPlayer.videos([token: "my_owesome_token"])
    
This function returns an tuple containing the status code and all information about the videos created, e.g:

    
        {200, [
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




### Get a specific video

    ChiliPlayer.video(1234, [token; "my_owesome_token"])

If video_id exists this call returns all information about the requested video, e.g:

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

### Upload video
Send a POST request with options map with data to upload videos in Chiligum Player Api. Its mandatory send headers with a valid token information.

    ChiliPlayer.upload(%{data: "https://s3.amazonaws.com/my_owesome_video.mp4", name: "My Owesome Video", preserve_original_file: false}, [token: "my_awesome_token"])

This method returns all information displayed at 'Get a specific video' topic.

### Update video
In order to update a video, you must pass as parameters the video's id and also optional parameters such as: name, postback_url, preserve_original_file, activated, watermark_image_url, watermark_link, watermark_position, wartermark_start, watermark_duration. When you update the video, you cannot change the video's file.

    ChiliPlayer.update(1234, %{name: "new name video, preserve_original_file: false"}, [token: "my_owesome_token"])


This method returns all information displayed at 'Get a specific video' topic.

### Delete a video
If you want to delete a previous uploaded video, you just need to pass the id of this video and a valid token

    ChiliPlayer.delete(1234, [token: "my_awesome_token"])    

If the video_id is valid, this function returns the message `{200, %{msg: "deleted"}}`

