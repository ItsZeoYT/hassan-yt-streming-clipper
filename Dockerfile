# Hassan Yt Streming Clipper: YouTube livestream recording and Shorts generation.
FROM python:3.11-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg ca-certificates bzip2 fonts-noto-core fonts-noto-cjk \
 && rm -rf /var/lib/apt/lists/*
# yt-dlp needs a JavaScript runtime for YouTube
COPY --from=denoland/deno:bin /deno /usr/local/bin/deno

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY studio studio
COPY web web

ENV YTCLIPPER_DATA=/data \
    YTCLIPPER_HOST=0.0.0.0 \
    YTCLIPPER_PORT=8788 \
    YTCLIPPER_TRUST_PROXY=1 \
    PYTHONUNBUFFERED=1
VOLUME /data
EXPOSE 8788
HEALTHCHECK --interval=30s --timeout=5s --start-period=120s CMD python -c "import os, urllib.request; urllib.request.urlopen('http://127.0.0.1:' + os.environ['YTCLIPPER_PORT'] + '/healthz', timeout=4)"
# the first start downloads the speech model into /data/models by itself (about 480 MB)
CMD ["python", "-m", "studio.server"]
