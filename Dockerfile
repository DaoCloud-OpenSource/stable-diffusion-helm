FROM python:3.10

ARG SD_WEBUI_VERSION=v1.6.0
ENV SD_WEBUI_VERSION=${SD_WEBUI_VERSION}

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui -b ${SD_WEBUI_VERSION} --depth 1

WORKDIR /stable-diffusion-webui

RUN apt update && \
    apt-get install bc ffmpeg libsm6 libxext6  -y --no-install-recommends google-perftools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo LD_PRELOAD=$(find /usr/lib -name libtcmalloc.so.4) >> /etc/environment

ENV venv_dir -

RUN useradd -U --home /stable-diffusion-webui sd

RUN sh -c "nohup bash webui.sh -f --exit --skip-torch-cuda-test --no-half >/tmp/sd.log &"; \
    start=$(date +%s); \
    while true; do \
        sleep 3; \
        if grep -q "Exiting because of --exit argument" /tmp/sd.log; then \
            break; \
        elif ! ps -ef | grep -q ./webui.sh; then \
            cat /tmp/sd.log; \
            exit 11; \
        else \
            echo "[$(($(date +%s)-${start}))s] preparing..."; \
        fi; \
    done && \
    rm -rf /root/.cache /tmp/sd.log && \
    chown -R sd:sd /stable-diffusion-webui

EXPOSE 7860

USER sd

ENTRYPOINT ["/usr/local/bin/python", "/stable-diffusion-webui/webui.py"]

CMD ["--listen", "--port", "7860"]
