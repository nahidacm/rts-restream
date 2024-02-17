## Description
A way to convert RTSP (Real Time Streaming Protocol) to HLS ( HTTP Live Streaming)

RTSP is mostly used in IP Camera. Javascript based browser's can't stream RTSP directly in browser.

This is a very simple and fast way of Re-stream RTSP.

### Installatin
in `ffmpeg-converter.sh` adjust your `VIDSOURCE` url. It should be your RTSP url.

E.g: `VIDSOURCE="rtsp://user:pass@101.155.220.126:544/Streaming/channels/101"`

### Convert the stream
`./ffmpeg-converter.sh`

This should generate `playlist.m3u8` and `playlist.ts` files in the `cctv-stream` folder.

Now Serve this `playlist.m3u8` as a static file from this directory.

### Frontend

In frontend, use some HLS player to steam this video.

### Using PM2 in backend
Keep the converter process up and running in backend: 
```bash
pm2 start ffmpeg-converter.sh --name rtsp-resteam-converter`
```
Serve the static stream
```bash
pm2 serve cctv-stream 3020 
```
The video source should be available in: http://your-domain.com/playlist.m3u8

### Using hls.js in frontend
Note: make sure you update the video source in following code

```html
<!DOCTYPE html>
<html>
    <head>
    <title>Live Cam</title>
    </head>
    <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
    <body>
        <!-- solution by: https://dev.to/tejasvi2/rtsp-stream-to-web-browser-using-ffmpeg-1cb -->
    <!-- Use this if you only support Safari!!
        <div id="player">
            <video id="video" autoplay="true" controls="controls">
                <source src="http://your-domain.com/playlist.m3u8" />
                Your browser does not support HTML5 streaming!
            </video>
        </div>
    -->
    <video id="video" autoplay="true" controls="controls" type='application/x-mpegURL' width="50%"></video>
    <script>
        if (Hls.isSupported()) {
        var video = document.getElementById('video');
        var hls = new Hls();
        // bind them together
        hls.attachMedia(video);
        hls.on(Hls.Events.MEDIA_ATTACHED, function () {
            console.log("video and hls.js are now bound together !");
            hls.loadSource("http://your-domain.com/playlist.m3u8");
            hls.on(Hls.Events.MANIFEST_PARSED, function (event, data) {
            });
        });
        }
    </script>
    </body>
</html>
```