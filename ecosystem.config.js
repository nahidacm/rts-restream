module.exports = {
  apps : [{
    name   : "rtsp-resteam-converter",
    script : "ffmpeg-converter.sh",
    out_file: "/dev/null"
  },
  {
    name   : "static-stream-server",
    script : "serve",
    env: {
      PM2_SERVE_PATH: 'cctv-stream',
      PM2_SERVE_PORT: 3020
    }
  },
]
}
