# Stable Diffusion

Stable Diffusion 是 HuggingFace 上著名英文文生图 Latent Diffusion 模型，可以根据任意的英文文本信息来生成拟真图片。

通过此应用（Helm）包部署，可以在集群中一键部署 Stable Diffusion 模型，支持 CPU/GPU 模式。

## 重要参数说明

| 参数名称 | 说明 | 默认值 |
| --- | --- | --- |
| deviceMode | `cpu` 或者 `gpu`，如果集群中无 GPU 设备，可设置成 `cpu`，将使用 cpu 进行计算。 | `gpu` |
| image.repository | 镜像地址，默认从 ghcr.io 拉取，如果速度慢可以尝试改为 `ghcr.m.daocloud.io/kebe7jun/stable-diffusion-webui` | `ghcr.io/kebe7jun/stable-diffusion-webui` |
| service.type | 服务暴露类型 | `ClusterIP` |
