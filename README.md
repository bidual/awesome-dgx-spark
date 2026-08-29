# Awesome DGX Spark [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> A curated list of awesome tools, guides, playbooks, and resources for the [NVIDIA DGX Spark](https://www.nvidia.com/en-us/products/workstations/dgx-spark/), the GB10 Grace Blackwell personal AI supercomputer.

DGX Spark is a desktop machine built on the GB10 Grace Blackwell Superchip (SM 12.1 / sm_121), with 128 GB of unified CPU+GPU memory. You can link two units over 200 Gb/s networking to run larger models. This list collects community projects for setting it up, serving models, fine-tuning, benchmarking, and day-to-day operation.

**Platform essentials:** `aarch64` · `CUDA 13.x` · `sm_121` · `128 GB unified memory` · `200 Gb/s NVLink-C2C`

## Contents

- [Official](#official)
- [Setup & Configuration](#setup--configuration)
- [Inference & Serving](#inference--serving)
  - [vLLM](#vllm)
  - [llama.cpp](#llamacpp)
  - [SGLang](#sglang)
  - [Other Engines](#other-engines)
- [Fine-tuning](#fine-tuning)
- [Quantization & NVFP4](#quantization--nvfp4)
- [Models & Benchmarks](#models--benchmarks)
- [Multi-node](#multi-node)
- [Image & Media Generation](#image--media-generation)
- [Audio & Speech](#audio--speech)
- [Science & HPC](#science--hpc)
- [Remote Access & Desktop](#remote-access--desktop)
- [Tools & Monitoring](#tools--monitoring)
- [Operating Systems & Containers](#operating-systems--containers)
- [Community & Resource Collections](#community--resource-collections)

## Official

- [NVIDIA/dgx-spark-playbooks](https://github.com/NVIDIA/dgx-spark-playbooks) - Step-by-step DGX Spark playbooks spanning vLLM, SGLang, llama.cpp, NVFP4 quantization, speculative decoding, cuTile kernels, NCCL, and two- and three-node clustering.

## Setup & Configuration

- [a1exus/sparky](https://github.com/a1exus/sparky) - Self-hosted DGX Spark LLM stack, vLLM, Ollama, and a llama.cpp router serving every cached GGUF behind Traefik, with mDNS, Cloudflare Tunnel, and Tailscale ingress.
- [Albatross1382/onnxruntime-aarch64-cuda-blackwell](https://github.com/Albatross1382/onnxruntime-aarch64-cuda-blackwell) - ONNX Runtime 1.24.4 CUDA shared libraries for sm_121 on aarch64, loaded through the Rust ort crate or dlopen.
- [botAGI/AGmind](https://github.com/botAGI/AGmind) - One-command private RAG stack for DGX Spark, Dify with vLLM, Weaviate, RAGFlow, and Docling across 30+ containers, plus two-node clustering over 200 Gb/s QSFP.
- [Chrizz-lab/GB10-Agentig-Coding-Framework](https://github.com/Chrizz-lab/GB10-Agentig-Coding-Framework) - Agentic coding stack for DGX Spark with dual-vLLM Qwen3 and CrewAI orchestration.
- [csabakecskemeti/dgx-spark-community-playbooks](https://github.com/csabakecskemeti/dgx-spark-community-playbooks) - Community playbook collection for DGX Spark, covering dual-Spark RDMA inference, heterogeneous RoCE clustering, and local Claude Code.
- [Entrpi/dgx-spark-serving-mode](https://github.com/Entrpi/dgx-spark-serving-mode) - Three-state serving-mode script for DGX Spark that pares GNOME and maintenance timers down to multi-user.target for 10-15 GB more unified memory.
- [getainode/ainode](https://github.com/getainode/ainode) - Browser-UI AI appliance for GB10 doing both inference and LoRA fine-tuning, with UDP-discovered multi-Spark tensor-parallel clustering verified on a 4-node 487 GB cluster.
- [GuigsEvt/dgx_spark_config](https://github.com/GuigsEvt/dgx_spark_config) - Source-build guide for LLVM, Triton, and PyTorch 2.9.1 against sm_121, with release wheels and ~1.5x on 8192 FP16 GEMM versus the stock cu130 build.
- [HeKun-NVIDIA/dgx-spark-openclaw](https://github.com/HeKun-NVIDIA/dgx-spark-openclaw) - Two-script deploy of a local LLM plus OpenClaw frontend, Qwen3.5-35B-A3B and MiniMax-M2.5-REAP-NVFP4 on a GB10 NVFP4-kernel vLLM image, or GLM-4.7-Flash on Ollama.
- [HendrikSchoettle/ragflow-dgx-spark](https://github.com/HendrikSchoettle/ragflow-dgx-spark) - Build and deploy pipeline for RAGFlow v0.24.0 on DGX Spark aarch64, with a source-built onnxruntime-gpu wheel for sm_121 and multilingual OCR.
- [install-safe-press/gb10-playbooks](https://github.com/install-safe-press/gb10-playbooks) - Chinese-language walkthrough of NVIDIA's official GB10 playbooks covering the basics and AI-agent sections, with hardware, DAC cabling, and Dell switch-config notes of its own.
- [JetBrains-Hardware/spark-setup](https://github.com/JetBrains-Hardware/spark-setup) - Remote deploy scripts for Qwen, GPT-OSS 120B, Nemotron 3 NVFP4, and Gemma 4 on vLLM, with MTP speculative decoding holding 14.4 tok/s at 200k context.
- [m9h/neurocontainers-arm](https://github.com/m9h/neurocontainers-arm) - Prebuilt causal-conv1d wheel plus four published neuroimaging containers built against NGC PyTorch CUDA 13, with locally built FreeSurfer 8.2.0 packages inside two of them.
- [mARTin-B78/dgx-spark_lite-llm_llama-swap_vllm_llama-cpp_ollama](https://github.com/mARTin-B78/dgx-spark_lite-llm_llama-swap_vllm_llama-cpp_ollama) - Multi-engine LLM stack for DGX Spark with llama-swap idle eviction behind a LiteLLM gateway, plus a harness pairing llama-benchy with a 69-scenario tool-calling bench.
- [natolambert/dgx-spark-setup](https://github.com/natolambert/dgx-spark-setup) - Training setup for CUDA 13.x on aarch64, cu130 vLLM wheels, SDPA over flash-attn, swap-off OOM guards, and profiled SFT, DPO, and LoRA batch ceilings.
- [seitzbg/onnxruntime-gpu-sm121-aarch64](https://github.com/seitzbg/onnxruntime-gpu-sm121-aarch64) - Prebuilt onnxruntime-gpu 1.27.1 aarch64 wheel, CUDA 13.x execution provider for sm_121, 7.3x over CPU on GB10.
- [Sggin1/DGX-SPARK](https://github.com/Sggin1/DGX-SPARK) - Dated GB10 lab notes, TurboQuant 3-bit KV cache at 240K context, dual-Spark 195 Gb/s RDMA, and sm_121a FP4 SASS evidence.
- [sjug/dgx-spark-ethernet-patch](https://github.com/sjug/dgx-spark-ethernet-patch) - Binary patch for the DGX Spark OOBE ethernet-detection bug, an 8-byte aarch64 HasInternet edit for FastOS 1.120.38.
- [Th0rgal/cuda-blackwell-carry-bug](https://github.com/Th0rgal/cuda-blackwell-carry-bug) - Repro for a PTXAS bug that drops the carry flag between separate inline-asm blocks on GB10 sm_121, with a Docker harness and a 128-bit reference path to compare against.
- [timothystewart6/ubuntu-gb10](https://github.com/timothystewart6/ubuntu-gb10) - Ubuntu 24.04 setup for GB10 in place of DGX OS, Ansible roles for NVIDIA driver, CUDA 13.x, DOCA-OFED, dual-node NCCL, and a 33-check read-only verify playbook.
- [tonyd2wild/DGX-Spark-Hard-Poweroff-Fix](https://github.com/tonyd2wild/DGX-Spark-Hard-Poweroff-Fix) - Diagnosis of GB10 log-less hard power-offs as an embedded-controller cut, fixed by a 2200 MHz clock cap and page-cache drops at 5% decode cost.

## Inference & Serving

### vLLM

- [0xSero/deepseek-v4-flash-0731-spark-sparkinfer](https://github.com/0xSero/deepseek-v4-flash-0731-spark-sparkinfer) - Single DGX Spark DeepSeek-V4-Flash-0731 on EXL3 weights and SparkInfer sparse MLA, 34 to 49 tok/s at 262K, with the 432-byte NVFP4 KV record disabled for text corruption.
- [AEON-7/vllm-ultimate-dgx-spark](https://github.com/AEON-7/vllm-ultimate-dgx-spark) - DGX Spark vLLM 0.26.0 image with Triton NVFP4 KV cache, DFlash, and NVFP4_AWQ checkpoint loading, reaching 1,151 tok/s at 128 concurrent on Gemma-4-26B-A4B.
- [airawatraj/dgx-spark-nemotron-super-agent](https://github.com/airawatraj/dgx-spark-nemotron-super-agent) - Nemotron-3-Super-120B agentic stack on DGX Spark scoring 93 of 100 on tool-eval-bench, with spark-arena 23.7 tok/s.
- [Anemll/dspark-vllm-gx10](https://github.com/Anemll/dspark-vllm-gx10) - Two-node GB10 port of DeepSeek-V4-Flash DSpark to vLLM 0.25.1 with nvfp4_ds_mla KV format and a b12x MXFP4 MoE backend, 48.5 tok/s decode at TP=2.
- [atcuality2021/vllm-gb10-gemma4](https://github.com/atcuality2021/vllm-gb10-gemma4) - Gemma 4 on GB10 through sm_121 fixes or a fork build with gemma4_mtp speculative decoding, 1.6x decode at 79.5% acceptance, plus vendored ManthanQuant 3-bit KV compression at 5.12x.
- [Avarok-Cybersecurity/dgx-vllm](https://github.com/Avarok-Cybersecurity/dgx-vllm) - vLLM image for DGX Spark with a custom NVFP4 kernel at 20% over AWQ INT4, peaking at 111.9 tok/s on an 80B model with MTP speculative decoding.
- [bjk110/spark_vllm_docker](https://github.com/bjk110/spark_vllm_docker) - vLLM serving from single DGX Spark TP=1 to dual-node TP=2 over 200 Gb/s RoCE, 38 presets pairing DeepSeek-V4-Flash and Solar-Open2-250B production images with pinned rollbacks.
- [blazux/qwen3.8-Flash-DGX](https://github.com/blazux/qwen3.8-Flash-DGX) - Qwen3.8-Flash-Next NVFP4 on one GB10 under vLLM with the n-gram table mapped from NVMe, 2,400 to 2,660 tok/s prefill against 540 on llama.cpp, 27 tok/s decode with MTP=2.
- [dolf3131/qwen3.8-flash-next-dgx-spark](https://github.com/dolf3131/qwen3.8-flash-next-dgx-spark) - Qwen3.8-Flash-Next NVFP4 on one DGX Spark with the 51B n-gram table paged to SSD swap, 30.0 tok/s at 524K context, and the silent hang when PLE offload meets TP=1.
- [drowzeys/Keys-Concurrency-Patch-for-DSpark-DeepSeek-V4-Flash](https://github.com/drowzeys/Keys-Concurrency-Patch-for-DSpark-DeepSeek-V4-Flash) - vLLM patch lifting DSpark speculative decoding past max-num-seqs 1, byte-identical single-stream output, 191 tok/s at 16 staggered streams on dual DGX Spark TP=2.
- [EmilHaase/DGX-Spark-VLLM-Hydra-Manager](https://github.com/EmilHaase/DGX-Spark-VLLM-Hydra-Manager) - vLLM manager for DGX Spark with sm_121a source builds and UMA KV-cache limits for multi-model launch.
- [Entrpi/ds4-spark-vllm](https://github.com/Entrpi/ds4-spark-vllm) - One-command 2-bit DeepSeek-V4-Flash vLLM install on a single DGX Spark, 85 GiB IQ2_XXS plus Q2_K checkpoint validated against antirez/ds4 at 1.75 tok/s under enforce-eager.
- [eugr/spark-vllm-docker](https://github.com/eugr/spark-vllm-docker) - vLLM Docker for one to eight DGX Sparks over Ray or native PyTorch distributed, 35 run-recipe.sh YAML recipes from Qwen3.6-35B to GLM-5.2-NVFP4.
- [jordanovski/overdrive](https://github.com/jordanovski/overdrive) - Web console and CLI for launching concurrent vLLM containers on DGX Spark, with preflight GPU-memory admission control and a SWE-bench page comparing resolution rates.
- [mark-ramsey-ri/vllm-dgx-spark](https://github.com/mark-ramsey-ri/vllm-dgx-spark) - Run vLLM on 1-to-N DGX Spark servers (single Spark, 2 via direct cable, or 3+ via switched fabric) to serve or benchmark LLMs.
- [MiaAI-Lab/Nemotron-Labs-3-Puzzle-75B-DGX-Spark](https://github.com/MiaAI-Lab/Nemotron-Labs-3-Puzzle-75B-DGX-Spark) - Nemotron-Labs-3-Puzzle-75B-A9B NVFP4 hybrid Mamba MoE on one DGX Spark, vLLM 0.24 launcher with aarch64 NCCL and FlashInfer cuda_ipc patches, 256K context, MTP k=3.
- [MiaAI-Lab/Ornith-1.5-35B-A3B-DGX-Spark](https://github.com/MiaAI-Lab/Ornith-1.5-35B-A3B-DGX-Spark) - Ornith-1.5-35B-A3B NVFP4 with in-checkpoint MTP on one DGX Spark, 86.3 to 440 tok/s at 24 streams, plus two b12x patches for CUDA-graph capture.
- [omnia-projetcs/spark-dgx](https://github.com/omnia-projetcs/spark-dgx) - Interactive vLLM Docker launcher for DGX Spark, 26 preset model configs from single-node NVFP4 to TP=8 Ray clusters, 11 with measured TTFT and concurrency tables.
- [saifgithub/vllm-gb10-sm121](https://github.com/saifgithub/vllm-gb10-sm121) - vLLM FP8 CUTLASS and NVFP4 dispatch patch for GB10 sm_121, with the sm120-only arch guard removed.
- [Sapid-Labs/vllm-spark-arena](https://github.com/Sapid-Labs/vllm-spark-arena) - Crowd-optimization arena for vLLM on sm_121, scoring sitecustomize.py patches over a pinned wheel as paired ratios, gated on byte-identical output and a held-out timed speedup.
- [spark-arena/sparkrun](https://github.com/spark-arena/sparkrun) - One-command launcher for vLLM, SGLang, and llama.cpp on one or more DGX Sparks, where --tp 2 means two hosts over auto-detected RDMA, plus git-based recipe registries.
- [sudoingX/dgx-spark-ling](https://github.com/sudoingX/dgx-spark-ling) - Official Ling-3.0-flash INT4 on one DGX Spark through the inclusionAI vLLM fork, 38.7 tok/s against 35.2 for the community GGUF, and decode collapse past 45K.
- [timothystewart6/vllm-gb10](https://github.com/timothystewart6/vllm-gb10) - Prebuilt GHCR vLLM image for GB10 (sm_121a) with NCCL and FlashInfer built from source, every input pinned by commit SHA or digest in versions.env.

### llama.cpp

- [0xBakeer/qwen38-flash-next-spark](https://github.com/0xBakeer/qwen38-flash-next-spark) - Qwen3.8-Flash-Next Q4 on one DGX Spark with its 51B n-gram table served from NVMe, 22.3 tok/s decode and 74.6 on copy-heavy edits under the ngram-mod drafter.
- [croll83/llama.cpp-dgx](https://github.com/croll83/llama.cpp-dgx) - Deprecated llama.cpp fork for DGX Spark, kept for its TurboQuant TQ3_0 KV cache and weight kernels, which upstream does not expose.
- [marknx/flash-next-gguf-tools](https://github.com/marknx/flash-next-gguf-tools) - Qwen3.8-Flash-Next GGUF split across one DGX Spark and an RTX 5090 over 10 GbE, 140 tok/s aggregate at eight streams that OOM-kill the single box, plus converter fixes.
- [phuongncn/qwen3.6-27b-speedhack-gx10-dgx-spark](https://github.com/phuongncn/qwen3.6-27b-speedhack-gx10-dgx-spark) - DFlash block-diffusion spec-decode llama.cpp fork for Qwen3.6-27B on GB10, 7-11 to 38-40 tok/s coding via a p_min drafting threshold, and 60-66 to 113 on a 35B-A3B MoE.
- [Sapid-Labs/llamacpp-spark-arena](https://github.com/Sapid-Labs/llamacpp-spark-arena) - Crowd-optimization arena for llama.cpp CUDA kernels on sm_121, with a thermal gate, alternating baseline and candidate runs, and referee-verified held-out speedup.
- [shamily/gemma4-llama-dgx-spark](https://github.com/shamily/gemma4-llama-dgx-spark) - Dockerized llama.cpp for all four Gemma 4 models on GB10, benchmarked at 69.9 tok/s tg128 for the 26B-A4B MoE against 11.0 for the dense 31B.

### SGLang

- [BTankut/dgx-spark-sglang-moe-configs](https://github.com/BTankut/dgx-spark-sglang-moe-configs) - Tuned Triton MoE configs for GB10's 101,376-byte shared memory limit, where SGLang defaults need 147,456 and EAGLE crashes, plus a glm47 tool-call parser backport for GLM-4.7-FP8.
- [hashd1ve/qwen38-flash-next-one-dgx-spark](https://github.com/hashd1ve/qwen38-flash-next-one-dgx-spark) - Qwen3.8-Flash-Next on one DGX Spark, 126.0 GiB of weights inside 121.63 GiB with the n-gram table mapped from a file, 41.5 tok/s on code at GSM8K parity.
- [hasso5703/dgx-spark-qwen38](https://github.com/hasso5703/dgx-spark-qwen38) - One-command SGLang service for Qwen3.8-27B NVFP4 on GB10 with DFlash2 speculative decode, 50 tok/s greedy median and 258 aggregate at 32 streams.
- [InquiringMinds-AI/longcat-next-multimodal](https://github.com/InquiringMinds-AI/longcat-next-multimodal) - LongCat-Next 75B-A3B any-to-any multimodal through one SGLang process on a single GB10, image generation and voice-clone TTS on OpenAI endpoints at w8a8_int8 after 4-bit collapsed both.
- [mark-ramsey-ri/sglang-dgx-spark](https://github.com/mark-ramsey-ri/sglang-dgx-spark) - Run SGLang on 1-to-N DGX Spark servers (single Spark, 2 via direct cable, or 3+ via switched fabric) to serve or benchmark LLMs.
- [MiaAI-Lab/Nemotron3.5-Lightning-DGX-Spark-RTX-5090-6000-PRO](https://github.com/MiaAI-Lab/Nemotron3.5-Lightning-DGX-Spark-RTX-5090-6000-PRO) - Nemotron 3.5 Lightning 30B-A3B NVFP4 with the DSpark draft model on one DGX Spark via SGLang, 4.93M-token KV pool and 48 concurrent at 1M context.
- [MiaAI-Lab/Qwen3.8-27B-SGLang-DGX-Spark](https://github.com/MiaAI-Lab/Qwen3.8-27B-SGLang-DGX-Spark) - Qwen3.8-27B NVFP4 on one DGX Spark with EAGLE/MTP, DSpark and DFlash2 as measured swap-in modes, GDN in bf16 and the scheduler pinned to the X5 cores.
- [robbiemu/dgx-spark-inference](https://github.com/robbiemu/dgx-spark-inference) - SGLang services on one DGX Spark under systemd with per-role memory budgets, refusing a launch that will not fit, on a digest-pinned v0.5.14-cu130 runtime.
- [scottgl9/sglang-spark-gb10-optimizations](https://github.com/scottgl9/sglang-spark-gb10-optimizations) - SGLang fork that routes NVFP4 through Marlin FP4 where CUTLASS returns zeros on sm_121, Qwen3.5-122B-A10B at 43-45 tok/s with ~90% MTP acceptance.
- [ubehera/sglang-spark](https://github.com/ubehera/sglang-spark) - SGLang patch stack for DGX Spark with an sm_121a-only sgl-kernel 0.4.4 wheel, model-agnostic TP=2 launch recipes at NEXTN k=3, and a systemd watcher that stops wedged nodes.
- [Weschera/Qwen3.8-27B-NVFP4-DFlash2-DGX-Spark](https://github.com/Weschera/Qwen3.8-27B-NVFP4-DFlash2-DGX-Spark) - Qwen3.8-27B NVFP4 with DFlash2 on one DGX Spark, digest-pinned, where a boot-time fp8_gemm autotune race decides between 42 and 33 tok/s for the process lifetime.

### Other Engines

- [antirez/ds4](https://github.com/antirez/ds4) - DwarfStar local inference engine in C for DeepSeek V4 Flash and GLM 5.2, with a `make cuda-spark` target and published GB10 numbers of 826 t/s prefill and 18.1 t/s decode.
- [Avarok-Cybersecurity/atlas](https://github.com/Avarok-Cybersecurity/atlas) - Pure-Rust inference engine for GB10, one binary over 15 model and quant kernel targets, TurboQuant KV cache, 131 tok/s on Qwen3.5-35B-A3B with MTP K=2.
- [blake-snc/sm121-kernels](https://github.com/blake-snc/sm121-kernels) - Hand-written PTX kernel library for sm_121 in 259 files, covering flash attention, GEMM, Gated DeltaNet, and MoE, driver-only via cudarc with FP8 attention at ~108 TFLOPS.
- [calico88x/DGX-Model-Manager](https://github.com/calico88x/DGX-Model-Manager) - Control plane for managing Ollama, SGLang, vLLM, llama.cpp, LocalAI, and ComfyUI on DGX Spark, with roles, API tokens, and Hugging Face cache inventory.
- [joshhu/meetaclawtaipei](https://github.com/joshhu/meetaclawtaipei) - Three concurrent NVFP4 vLLM models on one DGX Spark with a 3-LLM voice-clone roommate demo.
- [kshetrajna12/sparkstation](https://github.com/kshetrajna12/sparkstation) - LLM gateway for DGX Spark fronting vLLM and SGLang under one OpenAI-compatible API, with profile-driven fleets, unified-memory admission control, and thermal-hysteresis auto-suspend.
- [lrozewicz/vLLM-Moet-GB10](https://github.com/lrozewicz/vLLM-Moet-GB10) - vLLM-Moet fork for one GB10, running DeepSeek-V4-Flash 304B at ~21 tok/s on code and 256K context via 2-bit expert planes with an FP4 delta tier.
- [mark-ramsey-ri/trt-dgx-spark](https://github.com/mark-ramsey-ri/trt-dgx-spark) - TensorRT-LLM serving on 1-to-N DGX Spark with an arm64 nvcr 1.2.1 container and tensor-parallel auto-scaling to cluster size.
- [rdaum/eider](https://github.com/rdaum/eider) - Rust and CUDA inference server for sm_121 NVFP4 with no tensor-runtime dependency, up on Qwen3.8-Flash-Next release day at 190 tok/s prefill and 11 to 13 decode.
- [rdoiron/mimo-mods-for-dgx-spark](https://github.com/rdoiron/mimo-mods-for-dgx-spark) - Ten vLLM runtime patches for MiMo-V2.5 on sm_121a, with a CUTLASS block-FP8 bypass and a backported tool-call corruption fix (PR #42969).
- [sf-stav/veloGB10](https://github.com/sf-stav/veloGB10) - Rust and CUDA inference engine built only for GB10, running Qwen3.6-35B at ~111 tok/s on one machine and ~130 on two over ConnectX-7, with prebuilt binaries.
- [Th0rgal/dgx-spark-router](https://github.com/Th0rgal/dgx-spark-router) - Stdlib-only OpenAI-compatible router that swaps ten llama.cpp and vLLM backends in and out of 128 GB unified memory, with per-model GB10 NVFP4 flags.
- [xangel82/DS4-GB10-GX10-DSpark-CUDA](https://github.com/xangel82/DS4-GB10-GX10-DSpark-CUDA) - DS4 fork for DeepSeek-V4-Flash on one GB10, lossless DSpark and HybridLC decode at 24-26 t/s on tool calls against the original 13, 900-953 t/s prefill.

## Fine-tuning

- [albond/DGX_Spark_Unsloth_Lossless_Speedup](https://github.com/albond/DGX_Spark_Unsloth_Lossless_Speedup) - Triton kernels for sm_121a that keep the loss curve bit-identical at 7.67x LoRA and 8.35x full fine-tune over stock Unsloth on Qwen3.5.
- [alicankiraz1/DGX-Spark-Asus-Ascent-Nvidia-GB10-SFT-Finetuner](https://github.com/alicankiraz1/DGX-Spark-Asus-Ascent-Nvidia-GB10-SFT-Finetuner) - No-code SFT fine-tuning tool for DGX Spark.
- [haven-jeon/unsloth-vllm-gb10](https://github.com/haven-jeon/unsloth-vllm-gb10) - Unsloth training and vLLM inference Docker image for DGX Spark GB10 with source-built xformers and Triton.
- [kreuzhofer/dgx-spark-unsloth-qwen3.5-training](https://github.com/kreuzhofer/dgx-spark-unsloth-qwen3.5-training) - BF16 LoRA on Qwen3.5-35B-A3B without quantization, eager per-shard CUDA loads and page-cache eviction that cut peak unified memory from 134 GB to 72 GB.
- [NvMayMay/nvfp4-lora-spark](https://github.com/NvMayMay/nvfp4-lora-spark) - LoRA trained on the served NVFP4 weights of a 100B+ MoE on one GB10, with a serve-time logprob check that catches no-op adapters.
- [ubehera/finetune](https://github.com/ubehera/finetune) - Unsloth LoRA fine-tune run on GB10 with five idempotent in-venv hotfixes and a committed perplexity table, 30.3 base to 14.3 after five epochs.
- [waybarrios/dgx-spark-finetune-llm](https://github.com/waybarrios/dgx-spark-finetune-llm) - LLM fine-tuning with LoRA + NVFP4/MXFP8 on DGX Spark.

## Quantization & NVFP4

GB10's Blackwell architecture supports NVFP4 (4-bit floating point) in hardware. It runs faster than INT4 at similar quality.

- [0xBakeer/Qwen3.8-27B-4-bit-on-a-single-DGX-Spark](https://github.com/0xBakeer/Qwen3.8-27B-4-bit-on-a-single-DGX-Spark) - Qwen3.8-27B 4-bit on one DGX Spark, NVFP4 with a DSpark draft at k=14 reaching 75 tok/s, its edge over FP8 falling from 27% at c1 to 0.2% at c16.
- [AEON-7/Gemma-4-26B-A4B-it-Uncensored-NVFP4](https://github.com/AEON-7/Gemma-4-26B-A4B-it-Uncensored-NVFP4) - NVFP4 Gemma 4 26B MoE on DGX Spark with DFlash speculative decoding, 49.8 tok/s on prose to 202.4 on extraction, and 1,937 tok/s aggregate at 64 concurrent.
- [AEON-7/Gemma-4-31B-Uncensored-NVFP4-DFlash](https://github.com/AEON-7/Gemma-4-31B-Uncensored-NVFP4-DFlash) - Prebuilt vLLM image for Gemma 4 31B Deckard Heretic with z-lab DFlash k=15 and CUTLASS NVFP4, decode 11 to 38.82 tok/s at c=1.
- [AEON-7/Nemotron-3-Nano-Omni-AEON-Ultimate-Uncensored](https://github.com/AEON-7/Nemotron-3-Nano-Omni-AEON-Ultimate-Uncensored) - Source-built vLLM image with sm_121a patches for abliterated multimodal Nemotron-3-Nano-Omni NVFP4, refusals down from 99/100 to 16/100 with thinking off.
- [AEON-7/Qwen3.6-35B-A3B-heretic-NVFP4-DFlash](https://github.com/AEON-7/Qwen3.6-35B-A3B-heretic-NVFP4-DFlash) - Source-built vLLM image serving NVFP4 Qwen3.6-35B-A3B with DFlash speculative decoding, averaging 97 tok/s single-stream across six prompt categories.
- [AEON-7/supergemma4-26b-abliterated-multimodal-nvfp4](https://github.com/AEON-7/supergemma4-26b-abliterated-multimodal-nvfp4) - Plain-NVFP4 SuperGemma4-26B abliterated multimodal for DGX Spark, as a prebuilt vLLM container, one loader patch down from three in the AWQ release.
- [BioInfo/turboquant-dgx](https://github.com/BioInfo/turboquant-dgx) - TurboQuant KV-cache quantization on GB10 with 3.88x compression and 8.4x Triton kernel speedup.
- [drowzeys/vLLm-0.24-optimized-NVIDIA-Nemotron-Lab-Puzzle-75B-A9B-A4Q-MTP3-NVFP4-KV-2.7M-Pool-Single-DGX-Spark](https://github.com/drowzeys/vLLm-0.24-optimized-NVIDIA-Nemotron-Lab-Puzzle-75B-A9B-A4Q-MTP3-NVFP4-KV-2.7M-Pool-Single-DGX-Spark) - Nemotron-Labs-3 Puzzle-75B-A9B on a single DGX Spark with an NVFP4 KV cache holding 2.71M tokens, MTP k=3, 25.8 tok/s decode and 220.3 aggregate at 32 streams.
- [jethac/vllm-nvfp4-kv-consumer-blackwell-repro](https://github.com/jethac/vllm-nvfp4-kv-consumer-blackwell-repro) - One-command repro for the vLLM NVFP4 KV V-scale swizzle bug on consumer and SoC Blackwell, run here on sm_120, showing corrupted versus fixed output and 3.4-3.6x KV capacity.
- [localai-org/apex-quant](https://github.com/localai-org/apex-quant) - MoE-aware mixed-precision GGUF recipe, Q8_0 perplexity at 21.3 GB instead of 34.4 GB and 62.3 against 52.5 t/s on Qwen3.5-35B-A3B, measured on GB10.
- [Logos-Flux/optimized-CUDA-GB10](https://github.com/Logos-Flux/optimized-CUDA-GB10) - Vectorized sm_121 RMSNorm kernel, 2.59x average over PyTorch BF16, on the Hugging Face Kernel Hub.
- [mitkox/sparser-faster-llms](https://github.com/mitkox/sparser-faster-llms) - GB10 sm_121 CUDA-core TwELL sparse-kernel port of SakanaAI's sparser-faster-llms for DGX Spark builds without Hopper WGMMA.
- [Plaaasma/FlashQLA-Blackwell](https://github.com/Plaaasma/FlashQLA-Blackwell) - FlashQLA TileLang Gated Delta Net kernels ported to GB10 sm_121, 2.76x over vLLM's bundled Triton GDN path at 32K, ~3% end-to-end TTFT on Qwen3.6-27B.
- [r0b0tlab/gemma4-26b-a4b-nvfp4-gb10-native-cutlass](https://github.com/r0b0tlab/gemma4-26b-a4b-nvfp4-gb10-native-cutlass) - Gemma-4-26B-A4B NVFP4 for GB10 via native VLLM_CUTLASS MoE backend on CUDA-13 nightly, 260 tok/s at concurrency 8.
- [r0b0tlab/gemma4-31b-it-nvfp4-gb10](https://github.com/r0b0tlab/gemma4-31b-it-nvfp4-gb10) - Gemma-4-31B-IT NVFP4 reproducibility pack for GB10 with native FlashInfer/CUTLASS FP4 GEMM, 54 tok/s at concurrency 8.
- [r0b0tlab/nemotron3-super-120b-a12b-nvfp4-gb10-native-mtp](https://github.com/r0b0tlab/nemotron3-super-120b-a12b-nvfp4-gb10-native-mtp) - Nemotron-3-Super-120B-A12B NVFP4 for GB10 on SGLang native MTP, 21.64 tok/s and +45.8% over baseline.
- [r0b0tlab/qwen36-35b-a3b-nvfp4-fast-sm121-vllm](https://github.com/r0b0tlab/qwen36-35b-a3b-nvfp4-fast-sm121-vllm) - Qwen3.6-35B-A3B NVFP4-Fast on one GB10 via sm_121-native vLLM, 80.6 tok/s single-stream to 344 tok/s at concurrency 32, with GSM8K 86.73% and 86.33% MTP acceptance over 474K draft tokens.
- [r0b0tlab/qwen36-35b-a3b-nvfp4-sm121-vllm](https://github.com/r0b0tlab/qwen36-35b-a3b-nvfp4-sm121-vllm) - NVIDIA Qwen3.6-35B-A3B-NVFP4 on one GB10 under vLLM 0.25.0, W4A16 targets routed to native W4A4, 93 tok/s single stream, GSM8K 86.5%, 262,144-token context qualified.
- [r0b0tlab/qwen38-27b-nvfp4-sm121-vllm](https://github.com/r0b0tlab/qwen38-27b-nvfp4-sm121-vllm) - Qwen3.8-27B NVFP4 with MTP on one GB10, published sm_121 vLLM image at 27.8 tok/s c1 against 20.4 on untuned nightly fp4_gemm, NIAH 8/8 at 262K.
- [RobTand/gridbook](https://github.com/RobTand/gridbook) - Product-codebook weight format and out-of-tree vLLM plugin whose decoded tiles are native NVFP4 or FP8, no Triton fallback, serving a 295B MoE at 2.9 bpp on one DGX Spark.
- [secYOUre/nvfp4bench](https://github.com/secYOUre/nvfp4bench) - NVFP4 peak-throughput CLI for GB10 sm_121a, 1022 TFLOPS sparse and 511 dense on packed mxf4nvf4 MMA, exactly half on byte-padded mxf8f6f4.
- [spped2000/thaillm-nvfp4-dgx-spark](https://github.com/spped2000/thaillm-nvfp4-dgx-spark) - ThaiLLM-30B quantized to NVFP4 on DGX Spark, 3.4x smaller at 63 tok/s decode, Thai accuracy flat under paired McNemar tests, MMLU down 1.4 points.
- [sudoingX/dgx-spark-laguna](https://github.com/sudoingX/dgx-spark-laguna) - Laguna S 2.1 NVFP4 on DGX Spark with DFlash, 25-30 tok/s at 128K, plus hard-hang protection.
- [vladimir-voinea/gb10-laguna-s-2.1-w4a16-moe](https://github.com/vladimir-voinea/gb10-laguna-s-2.1-w4a16-moe) - W4A16 grouped-MoE kernels and GB10-tuned Triton configs for sm_121a, reaching 157-230 GB/s achieved weight bandwidth against 109-142 for stock Triton on a 117B MoE.

## Models & Benchmarks

- [albond/DGX_Spark_Qwen3.5-122B-A10B-AR-INT4](https://github.com/albond/DGX_Spark_Qwen3.5-122B-A10B-AR-INT4) - Qwen3.5-122B-A10B on DGX Spark, tuned from 28.3 to 52 tok/s (+82%) with a hybrid INT4+FP8 checkpoint and an INT8 LM head.
- [Avarok-Cybersecurity/atlas-recipes](https://github.com/Avarok-Cybersecurity/atlas-recipes) - Recipe registry for the Atlas engine on GB10, reserved as the @atlas namespace in sparkrun defaults, with per-model NVFP4 KV and MoE settings and measured tok/s.
- [Blackwellboy/laguna-s21-lab](https://github.com/Blackwellboy/laguna-s21-lab) - Laguna S 2.1 NVFP4 testing lab on one DGX Spark, 20-cell tuning sweep with its losing cells, 12-hour soak of 3,096 turns, and 450-turn thinking-gate study.
- [DanTup/spark-evals](https://github.com/DanTup/spark-evals) - Generated leaderboard of BFCL, BigCodeBench, and IFEvalCode scores over 29 model and quantization configurations that fit on a single DGX Spark, with per-run inspect-evals logs.
- [elsung/dgx-spark-deepseek-v4-flash](https://github.com/elsung/dgx-spark-deepseek-v4-flash) - DeepSeek-V4-Flash official FP8 across two DGX Spark under vLLM TP=2 over a 200 Gb/s QSFP56 RoCE cable, 41 tok/s single stream and ~350 aggregate at c=32.
- [Entrpi/ds4-on-spark](https://github.com/Entrpi/ds4-on-spark) - DGX Spark fork of antirez/ds4 at 2.4-3.3x upstream prefill and 1.33-1.47x decode, adding continuous batching at 59 tok/s over 12 concurrent requests and prefix caching that cuts warm TTFT ~7x.
- [Entrpi/qwen3.5-122B-A10B-on-spark](https://github.com/Entrpi/qwen3.5-122B-A10B-on-spark) - Qwen3.5-122B-A10B on a single DGX Spark via DFlash block-diffusion spec-decode, 81 tok/s on agent traffic.
- [GaelicThunder/colibri-gb10-attention-cliff](https://github.com/GaelicThunder/colibri-gb10-attention-cliff) - Fixed-size kernel guard at 8192 context tokens in colibri on GB10, silent CPU fallback at 0.45 versus 0.86 tok/s, plus per-branch counters and a sweep harness.
- [GaelicThunder/gb10-uma-inference-notes](https://github.com/GaelicThunder/gb10-uma-inference-notes) - Five measured GB10 unified-memory properties that hold across models and engines, including host-to-device copies as pure waste worth 63% once removed.
- [GaelicThunder/moe-offload-findings](https://github.com/GaelicThunder/moe-offload-findings) - Nine findings on MoE decode with experts streamed from NVMe, mostly negative: batching does not amortize expert reads and prefetching cannot beat a static pin.
- [gitcommit90/qwen38-27b-dgx-spark](https://github.com/gitcommit90/qwen38-27b-dgx-spark) - Qwen3.8-27B NVFP4 on one GB10 with Inco DFlash 2 speculative decoding, 44.46 tok/s versus DSpark 31.95 at k=7, plus a BF16 lm_head guard fix.
- [jeremy-newhouse/dgx-spark-nemotron-super-bench](https://github.com/jeremy-newhouse/dgx-spark-nemotron-super-bench) - Single-stream decode benchmark of Nemotron-3-Super-120B-A12B-NVFP4 on one GB10, ~26-27 tok/s realistic with MTP vs ~33.6 microbench.
- [jiayuqi7813/DeepSeek-V4-Flash-0731-CRACK-2x-DGX-Spark](https://github.com/jiayuqi7813/DeepSeek-V4-Flash-0731-CRACK-2x-DGX-Spark) - Rank-1 Householder refusal edit of DeepSeek-V4-Flash-0731 in native FP8 UE8M0 blocks on two DGX Spark, compliance 3.53 to 90.59% with HumanEval 148 against 150.
- [jvr0x/dgx-spark-bench](https://github.com/jvr0x/dgx-spark-bench) - Closed-loop concurrency sweeps on DGX Spark with pinned recipes and a GitHub Pages dashboard, per-session and aggregate tok/s across 34 published runs.
- [Kleybrink/dgx-spark-bench](https://github.com/Kleybrink/dgx-spark-bench) - Ollama benchmarking framework for DGX Spark measuring throughput, latency, memory, and answer quality with an LLM-as-a-judge pipeline over 21 prompts in 9 categories.
- [marksunner/dgx-spark-single-stack](https://github.com/marksunner/dgx-spark-single-stack) - Single-box agent stack on DGX Spark, Hermes runtime and Honcho memory on CPU beside vLLM serving Qwen3.5-122B hybrid INT4+FP8 with MTP at 41-47 tok/s.
- [marksunner/dgx-spark-step37-flash](https://github.com/marksunner/dgx-spark-step37-flash) - StepFun's Step 3.7 Flash (198B MoE) on a single DGX Spark with llama.cpp at ~27 tok/s and 96K context on a q8_0 KV cache, reduced from 128K for CUDA-graph stability.
- [martimramos/dgx-spark-ml-guide](https://github.com/martimramos/dgx-spark-ml-guide) - Troubleshooting playbook for PyTorch on GB10, 16 numbered failures with an error-to-fix table, from cu128 nightly wheels to aarch64 mmcv builds and NVRTC symlinks.
- [Memoriant/dgx-spark-kv-cache-benchmark](https://github.com/Memoriant/dgx-spark-kv-cache-benchmark) - KV cache quantization on GB10: q4_0 costs 37% of generation throughput at 110K context, TurboQuant turbo3 up to 23.6% at 32K, and prompt processing is untouched.
- [msuiche/weightless](https://github.com/msuiche/weightless) - Refusal steering applied at serve time instead of redistributed weights, with a GGUF layer-projection format and lanes for DeepSeek-V4-Flash, Qwen3.8-27B and Qwen3.8-Flash-Next on DGX Spark.
- [nabe2030/dense-27b-31b-dgx-spark](https://github.com/nabe2030/dense-27b-31b-dgx-spark) - Dense Qwen 3.5/3.6-27B and Gemma 4-31B on llama.cpp b8922, Q4_K_M at 10-12 tok/s versus 3.8-4.5 BF16, JCommonsenseQA cost 0.2-0.6 points.
- [nabe2030/gemma4-vs-qwen35-dgx-spark](https://github.com/nabe2030/gemma4-vs-qwen35-dgx-spark) - Gemma 4 26B-A4B versus Qwen 3.5/3.6-35B-A3B MoE on llama.cpp, F16 thinking-mode bug isolated, 26.5 against 58 tok/s decode and 0.35 point JCommonsenseQA spread.
- [OscarActual/gb10-llm-benchmark](https://github.com/OscarActual/gb10-llm-benchmark) - Ollama benchmarks for GB10 across 11 LLMs and 10 embedders: decode tok/s, TTFT, and Czech RAG recall.
- [pendakwahteknologi/gx10-benchmarks](https://github.com/pendakwahteknologi/gx10-benchmarks) - Benchmark roster for the ASUS Ascent GX10 (GB10) with nine published runs across inference, training, efficiency, and generation, each carrying timestamped CSV and log artifacts.
- [r0b0tlab/deepseek-v4-flash-nvfp4-gb10-benchmark](https://github.com/r0b0tlab/deepseek-v4-flash-nvfp4-gb10-benchmark) - DeepSeek-V4-Flash FP8 on two DGX Spark nodes (TP=2, MTP, RoCE), 5 to 38.4 tok/s from the pinned sm_121a vLLM build, 144.6 aggregate at c=16.
- [r0b0tlab/diffusiongemma-26b-nvfp4-sm121-vllm](https://github.com/r0b0tlab/diffusiongemma-26b-nvfp4-sm121-vllm) - DiffusionGemma 26B-A4B NVFP4 under vLLM on GB10 with the FlashInfer CUTLASS FP4 MoE path, 146.3 tok/s at c1 and 242.9 at c16, no Marlin fallback.
- [r0b0tlab/laguna-s-2.1-nvfp4-sm121-vllm](https://github.com/r0b0tlab/laguna-s-2.1-nvfp4-sm121-vllm) - Laguna S 2.1 NVFP4 on GB10 pinned to an exact checkpoint revision, with DFlash K=7 at 22.2 tok/s and an 8,620-case scorecard behind a checksummed verdict.
- [r0b0tlab/nex-n2-mini-nvfp4](https://github.com/r0b0tlab/nex-n2-mini-nvfp4) - NVFP4 vLLM container for Nex-N2-mini (Qwen3.5-MoE-35B) on GB10, 185 tok/s aggregate at concurrency 8.
- [r0b0tlab/step37-flash-nvfp4-sm121-vllm-docker](https://github.com/r0b0tlab/step37-flash-nvfp4-sm121-vllm-docker) - vLLM container for StepFun's Step 3.7 Flash NVFP4 (198B MoE VLM) on dual GB10 TP=2, with verified native-CUTLASS sm_121 execution at 16.49 tok/s.
- [styles01/sparkrun-recipes](https://github.com/styles01/sparkrun-recipes) - Recipe registry and runbooks for 13 models measured on one GB10, from MedGemma 27B to Puzzle 75B, where GMU above 0.55 hard-freezes the node.
- [VincentMarquez/glm52-gb10-colibri](https://github.com/VincentMarquez/glm52-gb10-colibri) - GLM-5.2 744B on a single DGX Spark at 11.1 tok/s decode with full top-8 routing, via CACHE_ROUTE expert residency the author wrote and merged upstream in colibri PR #199.
- [Weschera/spark-bench](https://github.com/Weschera/spark-bench) - LLM benchmark for DGX Spark across 76 scenarios and 12 domains, with 12 multi-turn agentic workflows and a TrueScore weighting that puts speed at 5%.

## Multi-node

You can connect two DGX Spark units directly over 200 Gb/s QSFP for double the memory and compute.

- [0xdfi/GLM-5.2-1M-4x-DGX-Spark](https://github.com/0xdfi/GLM-5.2-1M-4x-DGX-Spark) - GLM-5.2 744B unpruned at 1M context on 4x DGX Spark with NVFP4 compact-KV, 42 tok/s peak.
- [0xdfi/GLM-5.2-R9-Adaptive-MTP-FULL-CUDA-4x-DGX-Spark](https://github.com/0xdfi/GLM-5.2-R9-Adaptive-MTP-FULL-CUDA-4x-DGX-Spark) - GLM-5.2 on four DGX Spark nodes with FULL CUDA graphs captured for every adaptive MTP depth, 420K and 520K context profiles, 83.4 tok/s at c4.
- [0xSero/glm-5.3-flash-sglang-sm121](https://github.com/0xSero/glm-5.3-flash-sglang-sm121) - GLM-5.3-Flash NVFP4 under SGLang on two or four DGX Spark, 22.69 tok/s single stream and 82.37 at eight on TP=4, digest-pinned with an acceptance checklist.
- [ArgentAIOS/dgx-spark-cluster](https://github.com/ArgentAIOS/dgx-spark-cluster) - Two-node DGX Spark guide with DMA-BUF NCCL settings for GB10 where nvidia-peermem GPU Direct fails, 93.5% DDP scaling on a 200 Gb/s RoCEv2 link.
- [bird/GLM-spark](https://github.com/bird/GLM-spark) - GLM-5.2 across four DGX Spark nodes, 1M context at 24.7 tok/s on unpruned Int4-Int8Mix weights, TP4 plus DCP4 KV sharding and lossless speculative decoding.
- [bumasoft/Qwen3.8-Flash-Next-TP3-DGX-Spark-VLLM](https://github.com/bumasoft/Qwen3.8-Flash-Next-TP3-DGX-Spark-VLLM) - Qwen3.8-Flash-Next FP8 across three DGX Spark at tensor-parallel 3, checkpoint padded in place at 60.9 tok/s, where padding key heads alone silently breaks the 1:3 GDN pairing.
- [chishiki37/dgx-spark-fabric](https://github.com/chishiki37/dgx-spark-fabric) - Switched MikroTik CRS812 fabric replacing the direct DAC between two DGX Spark nodes, fixing broken RoCE for 26-33% more decode, with 100 and 200 Gb/s breakouts measured identical.
- [ciprianveg/gb10-glm-5.2](https://github.com/ciprianveg/gb10-glm-5.2) - GLM-5.2 Int4-Int8Mix on eight GB10 nodes via TP8, MoonViT-3d vision and adaptive MTP 2/4/5, ~1,341 t/s prefill, prebuilt sm_121 images.
- [ciprianveg/gb10-vllm](https://github.com/ciprianveg/gb10-vllm) - KIMI-K3 MXFP4 experts on sixteen GB10 nodes at TP16 plus DCP8, 2M total KV and a 270K-context NaN loop traced to the sharded KDA position cache.
- [CosmicRaisins/glm-5.2-gb10](https://github.com/CosmicRaisins/glm-5.2-gb10) - Unpruned GLM-5.2 Int4-Int8Mix on four GB10 nodes with DCP KV sharding, 320K context at 598 t/s prefill or 640K at 430, decode flat near 22 t/s.
- [CosmicRaisins/minimax-m3-awq-gb10](https://github.com/CosmicRaisins/minimax-m3-awq-gb10) - MiniMax-M3-AWQ-INT4 vLLM serve recipe for 4x GB10, FP8 KV cache, EAGLE3 spec-decode, and indexer-corruption fix.
- [digchick/dgx-spark-200g-link-fix](https://github.com/digchick/dgx-spark-200g-link-fix) - Troubleshooting playbook for the 200G ConnectX-7 link failing to train between two Sparks (CX7 hotplug power-saving), with the fix and NCCL/RoCE verification.
- [drowzeys/Keys-Setup-Autonomous-Self-Improving-Local-Inference-Stack](https://github.com/drowzeys/Keys-Setup-Autonomous-Self-Improving-Local-Inference-Stack) - Mixture-of-Agents stack for four DGX Spark nodes with a DeepSeek-V4-Flash router and an NVFP4 Two-Tower consolidated onto one node at 29 tok/s.
- [FujitsuPolycom/sparkring](https://github.com/FujitsuPolycom/sparkring) - Switchless collective transport and vLLM serving for DGX Spark pairs and four-node rings, custom RDMA collectives with CUDA-graph command rings and a patched NCCL.
- [hazyumps/deepseek-v4-flash-gb10](https://github.com/hazyumps/deepseek-v4-flash-gb10) - Dual DGX Spark recipe for DeepSeek-V4-Flash-0731 at 384K context, prebuilt sm_121 image with DSpark speculative decoding, 1.6 to 1.8k tok/s prefill, NCCL 2.30.4 deadlock fix.
- [HeNryous/mimo-v25-dflash-dgx-spark](https://github.com/HeNryous/mimo-v25-dflash-dgx-spark) - MiMo-V2.5 (309B MoE, NVFP4 plus a required MXFP8 o_proj overlay) on two DGX Spark nodes, DFlash drafting ~54 tok/s on structured content, 1.67M-token fp8 KV pool at 500K.
- [idonati/spark-vllm-docker-festr2](https://github.com/idonati/spark-vllm-docker-festr2) - vLLM patches for festr2 MiMo-V2.5-Pro NVFP4/MXFP8 on an 8-node sm_121 cluster, fused-QKV fix for Q mis-slotted as K/V on 7 of 8 ranks, 114 tok/s aggregate at 20 concurrent.
- [joesinvestments/GLM-5.2-QuantTrio-TP4-DCP2-4x-DGX-Spark](https://github.com/joesinvestments/GLM-5.2-QuantTrio-TP4-DCP2-4x-DGX-Spark) - GLM-5.2 QuantTrio Int4-Int8Mix TP=4 plus DCP on four DGX Spark, where VLLM_MARLIN_USE_ATOMIC_ADD moves quantized-draft decode 6.5 to 44.6 tok/s and a cudagraph capture-ladder gap wedges the sparse MLA indexer.
- [joesinvestments/glm52-spark-kit](https://github.com/joesinvestments/glm52-spark-kit) - GLM-5.2 on four DGX Spark as source overlays over stock vLLM, fused nvfp4_ds_mla KV writer at 51 times the torch reference, sparse indexer unblocked above DCP 1.
- [joeynyc/Hy3-295B-NVFP4-2x-DGX-Spark](https://github.com/joeynyc/Hy3-295B-NVFP4-2x-DGX-Spark) - Hunyuan 3 295B MoE (NVFP4) on two DGX Sparks with vLLM and Ray, 26 tok/s single-stream at 262K context with TurboQuant k8v4 KV cache, plus upstream vLLM fixes (#47792, #47777).
- [joeynyc/MiniMax-H3-2x-DGX-Spark](https://github.com/joeynyc/MiniMax-H3-2x-DGX-Spark) - Cross-host diffusion executor for one MiniMax H3 video across two DGX Spark nodes, Ulysses sequence parallelism over RoCEv2, 68.8 s against 155.0 s single-box.
- [josephdrose/nccl-spark-switchless](https://github.com/josephdrose/nccl-spark-switchless) - NCCL 2.30.7 patches for a switchless 4-node GB10 RoCE ring, tree-skip plus 2-hop relay over the uncabled diagonals, MiniMax-M3 229B NVFP4 at ~24 tok/s.
- [karolpalys/glm52-triple-spark-tuning](https://github.com/karolpalys/glm52-triple-spark-tuning) - Tuning log and negative results for GLM-5.2 753B on three DGX Spark nodes, with the measurement methodology and the evidence that killed each rejected change.
- [kingjones30/GLM-5.3-Flash-2x-DGX-Spark](https://github.com/kingjones30/GLM-5.3-Flash-2x-DGX-Spark) - GLM-5.3-Flash NVFP4 on two DGX Spark, NoPE latent padded to the rope width sm_121 kernels expect, 24.7 tok/s on code under MTP-5 on the stock image.
- [Libertai/glm53-flash-vllm-gb10](https://github.com/Libertai/glm53-flash-vllm-gb10) - GLM-5.3-Flash under vLLM on two DGX Spark at 24.2 tok/s through a hand-written sparse-MLA kernel, with degenerate output traced to an uninitialized MoE activation scale.
- [makiisthenes/dgx-spark-multinode-vllm-ray](https://github.com/makiisthenes/dgx-spark-multinode-vllm-ray) - Dual-DGX Spark vLLM deployment with NVIDIA vLLM 26.04, Ray, and 200 GbE QSFP.
- [maliubiao/dgx-spark-2-deepseek-flash-0731](https://github.com/maliubiao/dgx-spark-2-deepseek-flash-0731) - Bilingual from-scratch manual for DeepSeek-V4-Flash-0731 on two DGX Spark, with LMCache v0.5.3 built on aarch64 for NVMe cold KV backup at a 1 GiB L1 cap.
- [MiaAI-Lab/DeepSeek-v4-Flash-DSpark-2x-DGX-Spark](https://github.com/MiaAI-Lab/DeepSeek-v4-Flash-DSpark-2x-DGX-Spark) - Two-node DeepSeek-V4-Flash-0731 on the Anemll GX10 image at a 1M-token ceiling, nvfp4_ds_mla KV and DSpark k=5, plus 18 hotfix patches keyed to numbered issues.
- [MiaAI-Lab/GLM-5.2-NVFP4-AQLM-Triple-DGX-Sparks](https://github.com/MiaAI-Lab/GLM-5.2-NVFP4-AQLM-Triple-DGX-Sparks) - NVFP4 plus AQLM 2-bit hybrid GLM-5.2 on three DGX Spark nodes at TP3, 348K vision context, 21 tok/s structured decode, top-8 routing regression fixed.
- [MiaAI-Lab/GLM-5.3-Flash-EXL3-2x-DGX-Sparks](https://github.com/MiaAI-Lab/GLM-5.3-Flash-EXL3-2x-DGX-Sparks) - GLM-5.3-Flash as EXL3 4 bpw on two DGX Spark at the full 1M context, 61.7 tok/s structured and 26.9 on prose under DFlash2 k=7.
- [MiaAI-Lab/GLM-5.3-Flash-NVFP4-Dual-DGX-Spark](https://github.com/MiaAI-Lab/GLM-5.3-Flash-NVFP4-Dual-DGX-Spark) - GLM-5.3-Flash NVFP4 on two DGX Spark over Ray TP=2 with image and video input, MTP at four draft tokens, FP8 KV cache and 262K context.
- [MiaAI-Lab/Inkling-Small-NVFP4-Dual-DGX-Sparks](https://github.com/MiaAI-Lab/Inkling-Small-NVFP4-Dual-DGX-Sparks) - Inkling-Small-NVFP4 across two DGX Spark on SGLang at a 1,142,712-token KV pool, 33.9 tok/s single stream, page size 1 required for the triton DSpark verify path.
- [MiaAI-Lab/Qwen3.8-Flash-Next-Dual-DGX-Sparks](https://github.com/MiaAI-Lab/Qwen3.8-Flash-Next-Dual-DGX-Sparks) - Qwen3.8-Flash-Next on two DGX Spark under SGLang TP=2, sm_121 Triton fallback for the sparse-attention path, 64.4 tok/s and 2.85M NVFP4 KV tokens.
- [nabe2030/dgx-spark-2node-rpc](https://github.com/nabe2030/dgx-spark-2node-rpc) - GLM-5.2 GGUF at 228.5 GB split across two DGX Spark nodes over llama.cpp RPC, CX7 measured as two ~100 Gb/s PCIe Gen5 x4 paths, RDMA vs TCP A/B.
- [OsakaTX/qwen3.8-flash-next-vllm-dgx-spark](https://github.com/OsakaTX/qwen3.8-flash-next-vllm-dgx-spark) - Qwen3.8-Flash-Next NVFP4 on two DGX Spark under vLLM from an open pull request, 44 tok/s per request and 162 aggregate at eight streams, plus an FP8 n-gram-loader gate.
- [pfn/spark-vllm-compose](https://github.com/pfn/spark-vllm-compose) - Head and worker Docker Compose files that run vLLM across DGX Spark nodes with native --nnodes/--node-rank instead of Ray, shipped services for Qwen3.5-397B-A17B-int4 and MiniMax-M2.7.
- [r0b0tlab/DeepSeek-V4-Flash-DSpark-v026-SM121](https://github.com/r0b0tlab/DeepSeek-V4-Flash-DSpark-v026-SM121) - Dual-GB10 DeepSeek-V4-Flash-0731 on vLLM 0.26 with a digest-pinned GHCR image and runtime gate, NIAH PASS at 1M, BFCL multi_turn_base 0.755, ~79 tok/s c1 decode.
- [rajsinghtechbot/dgx-spark-vllm-k8s](https://github.com/rajsinghtechbot/dgx-spark-vllm-k8s) - Kubernetes cookbook for DeepSeek-V4-Flash on dual DGX Spark, with Multus/Spiderpool RDMA over RoCEv2, UMA-aware container memory limits, and Prometheus monitoring.
- [raullenchai/twinspark](https://github.com/raullenchai/twinspark) - Self-healing two-node vLLM cluster for DeepSeek-V4-Flash-0731 on DGX Spark at 74.8 tok/s, needle sweep cutting long-context failures from 8/25 to 2/25 by trading nvfp4_ds_mla KV for fp8_ds_mla.
- [Reederey87/dgx-spark-2x-deepseek-v4-flash](https://github.com/Reederey87/dgx-spark-2x-deepseek-v4-flash) - DeepSeek-V4-Flash-0731 on two DGX Spark from a full-source vLLM main build, four gated one-file upstream fix layers promoted on Welch non-inferiority, 3,027,217-token KV pool.
- [RustRunner/DGX-Llama-Cluster](https://github.com/RustRunner/DGX-Llama-Cluster) - Three DGX Spark nodes as a switchless ConnectX-7 RDMA star running llama.cpp RPC, 384 GB pooled unified memory for 400B+ models in 4-bit, NFS model share.
- [tomsti/guides](https://github.com/tomsti/guides) - GB10 cluster guide for DGX Spark over ConnectX-7 RoCE, covering NCCL rail pinning, the duplicate-MAC workaround, and MikroTik 400G switching.
- [tonyd2wild/DeepSeek-v4-Flash-0731-DSpark-1M-NVFP4-KV-2x-DGX-Spark](https://github.com/tonyd2wild/DeepSeek-v4-Flash-0731-DSpark-1M-NVFP4-KV-2x-DGX-Spark) - DeepSeek-V4-Flash-DSpark at 1M context on dual DGX Spark, patching the twelve draft tensors vLLM drops on the 0731 weights for 78 tok/s, plus a stop-string fix lifting GSM8K to 0.98.
- [tonyd2wild/ds4-h3-video-gen-factory](https://github.com/tonyd2wild/ds4-h3-video-gen-factory) - DeepSeek-V4-Flash at 1M context beside two MiniMax H3 video renders on two DGX Spark, 35% of idle throughput kept, and a load order set by H3's 50 GB footprint.
- [tonyd2wild/GLM-5.2-655K-MTP-4x-DGX-Spark---25-32tok-s](https://github.com/tonyd2wild/GLM-5.2-655K-MTP-4x-DGX-Spark---25-32tok-s) - GLM-5.2 744B unpruned (QuantTrio Int4-Int8Mix) at 655,360-token context across four DGX Spark nodes via decode-context-parallelism, 23.0 tok/s single and 47.9 aggregate at 4 concurrent, MTP k=3.
- [tonyd2wild/GLM-5.2-QuantTrio-200K-4x-DGX-Spark--36tok-s](https://github.com/tonyd2wild/GLM-5.2-QuantTrio-200K-4x-DGX-Spark--36tok-s) - Speed-shape recipe for unpruned GLM-5.2 at 200K context on four DGX Spark nodes, 36 tok/s peak, 75 aggregate at 6 concurrent, 63% of each step overhead.
- [tonyd2wild/GLM-5.3-Flash-NVFP4-2x-DGX-Spark](https://github.com/tonyd2wild/GLM-5.3-Flash-NVFP4-2x-DGX-Spark) - GLM-5.3-Flash NVFP4 on two DGX Spark at 21.8 tok/s and four at 35.7, NoPE sparse-MLA extended to sm_121, seven day-0 bugs traced across vLLM and FlashInfer.
- [tonyd2wild/GLM-5.3-Flash-NVFP4-DFlash2-2x-DGX-Spark](https://github.com/tonyd2wild/GLM-5.3-Flash-NVFP4-DFlash2-2x-DGX-Spark) - GLM-5.3-Flash NVFP4 on two DGX Spark at 46.9 tok/s under the DFlash2 drafter against 21.8 on MTP-4, where KV headroom differs 4 to 5 GiB between ranks.
- [tonyd2wild/MiMo-V2.5-TP2-1M-NVFP4-KV-2xDGX-Spark](https://github.com/tonyd2wild/MiMo-V2.5-TP2-1M-NVFP4-KV-2xDGX-Spark) - MiMo-V2.5 Omni at tensor-parallel 2 on two DGX Spark, NVFP4 4-bit KV cache for a 2.17M-token pool at 1M context, thinking-OFF eval 97.8 against 90.6.
- [tonyd2wild/MiMo-V2.5-TP3-NVFP4-KV-3xDGX-Spark](https://github.com/tonyd2wild/MiMo-V2.5-TP3-NVFP4-KV-3xDGX-Spark) - MiMo V2.5 Omni (310B MoE, text/image/video/audio) at tensor-parallel 3 across three DGX Sparks, with 4-bit NVFP4 KV cache for a ~10.6M-token KV pool at 1M context.
- [tonyd2wild/MiniMax-M3-2x-DGX-Spark-36-tok-s](https://github.com/tonyd2wild/MiniMax-M3-2x-DGX-Spark-36-tok-s) - MiniMax-M3 428B unpruned on two DGX Sparks, W4A16 GPTQ with NVFP4 KV cache and EAGLE-3, 36.6 tok/s at 196K context.
- [tonyd2wild/Minimax-M3-NVFP-3x-DGX-Sparks-TP-3](https://github.com/tonyd2wild/Minimax-M3-NVFP-3x-DGX-Sparks-TP-3) - MiniMax-M3 NVFP4 428B-A23B at tensor-parallel 3 across three DGX Sparks, 10.5 tok/s at 200K context over a switchless 200 Gb/s RoCE mesh.
- [tonyd2wild/nfs-model-weights](https://github.com/tonyd2wild/nfs-model-weights) - NFS recipe for sharing one checkpoint across N DGX Spark nodes, taking a 4-node model library from 6.8 TB to 1.7 TB with no per-node copies.
- [tonyd2wild/Qwen3.8-Flash-Next-NVFP4-DGX-Spark](https://github.com/tonyd2wild/Qwen3.8-Flash-Next-NVFP4-DGX-Spark) - Qwen3.8-Flash-Next NVFP4 on two DGX Spark with the FlashInfer sparse-decode kernel unblocked for sm_121, 70.2 tok/s peak under CUDA graphs, and a fused-mrope out-of-bounds fix.
- [tonyliu312/GLM-5.3-Flash-1M-Context-4x-DGX-Spark](https://github.com/tonyliu312/GLM-5.3-Flash-1M-Context-4x-DGX-Spark) - GLM-5.3-Flash at the full 1,048,576-token context on four DGX Spark, with the 262,144 community ceiling traced to a null-block livelock that reports every metric healthy.
- [tpurtell/glm-5.2-4x-spark-1x-rtx6k-96gb](https://github.com/tpurtell/glm-5.2-4x-spark-1x-rtx6k-96gb) - Rust attention-FFN disaggregation engine splitting GLM-5.2 across one RTX PRO 6000 coordinator and four DGX Spark expert nodes, at 64 tok/s decode and 1,650 prefill, 28 weighted across mixed workloads.
- [urbanspr1nter/dgx-spark-bare-metal](https://github.com/urbanspr1nter/dgx-spark-bare-metal) - Four-node DGX Spark Ray/vLLM cluster (480 GB) for MoE serving, with an sm_121 CUTLASS FP8 patch.
- [vroomfondel/dgxarley](https://github.com/vroomfondel/dgxarley) - Ansible playbooks for a K3s cluster of four DGX Spark nodes and an x86 control plane, SGLang over SR-IOV RoCE at 9.78 GB/s NCCL bus bandwidth.
- [www-ai-rs/gb10-deepseek-v4-flash](https://github.com/www-ai-rs/gb10-deepseek-v4-flash) - Two-node GB10 operator tooling and executed-code test harness for DeepSeek-V4-Flash 304B at 1M context, GPU rail power sampled at 2 Hz.
- [ZD-AI-Lab/Triple-GB10](https://github.com/ZD-AI-Lab/Triple-GB10) - Three-node GB10 QSFP ring with three /30 subnets and forwarding routes, pooling about 300 GB for Ray and vLLM pipeline-parallel across 3 Sparks.
- [zorost/sparkduet](https://github.com/zorost/sparkduet) - Model-swap layer for two DGX Spark, four checkpoints on disk behind one OpenAI port, DeepSeek-V4-Flash from 72.2 tok/s on math down to 33.6 on prose by draft acceptance.

## Image & Media Generation

- [AEON-7/comfyui-aeon-spark](https://github.com/AEON-7/comfyui-aeon-spark) - ComfyUI Docker for DGX Spark with SageAttention v3 compiled for sm_121a, CUDA 13, NVFP4, and Flux 2 / LTX 2.3 pre-bundled.
- [bjarkebolding/spark-comfyui](https://github.com/bjarkebolding/spark-comfyui) - Single-script containerized ComfyUI for DGX Spark, sm_121 SageAttention and sha256-verified workflow recipes, with a 2100 MHz clock cap for overcurrent reboots.
- [CoconutMacaroon/blender-arm64](https://github.com/CoconutMacaroon/blender-arm64) - Blender build for GB10 aarch64 with CUDA, OptiX, and Vulkan, shipping a prebuilt DGX Spark binary release.
- [dr-vij/ComfyUI-DGX-Spark-Docker-opinionated](https://github.com/dr-vij/ComfyUI-DGX-Spark-Docker-opinionated) - ComfyUI Docker for DGX Spark with self-built aarch64 wheels for decord NVDEC, comfy-aimdo, and flash-attn on sm_121, plus a SAM3 blacklist for WanVAE hangs.
- [dr-vij/Hunyuan3D-2.1-DGX-Spark-Docker](https://github.com/dr-vij/Hunyuan3D-2.1-DGX-Spark-Docker) - Hunyuan3D-2.1 3D generation on DGX Spark via Docker Compose, building custom_rasterizer and DifferentiableRenderer CUDA components on-box.
- [dr-vij/Trellis2-DGX-Spark-Docker](https://github.com/dr-vij/Trellis2-DGX-Spark-Docker) - Dockerized TRELLIS.2 3D generation for DGX Spark, with nvdiffrast, CuMesh, FlexGEMM, and torchvision built from source for sm_121 on CUDA 12.9.
- [ecarmen16/SparkyUI](https://github.com/ecarmen16/SparkyUI) - Dockerized ComfyUI for DGX Spark with unified-memory launch flags, aarch64 cu130 PyTorch, and SageAttention 2.2.0 compiled for sm_121.
- [joeynyc/cosmos-locateanything-dgx](https://github.com/joeynyc/cosmos-locateanything-dgx) - Two-stage DGX Spark pipeline: Cosmos 3 video generation, then NVIDIA LocateAnything object grounding.
- [joeynyc/MiniMax-H3-DGX-Spark](https://github.com/joeynyc/MiniMax-H3-DGX-Spark) - MiniMax H3 FL2VA video generation on one DGX Spark via vLLM-Omni and online FP8, sm_121 loader and AdaLN patch, 111 s warm request or 80 s with Cache-DiT.
- [kabilankb/cosmos3-nano-gb10](https://github.com/kabilankb/cosmos3-nano-gb10) - Cosmos3-Nano 16B video and image generation on a single GB10 instead of NVIDIA's recommended 8x H100, 480p 57-frame clips in about 3 minutes.
- [luix93/DGX-Spark-ComfyUI](https://github.com/luix93/DGX-Spark-ComfyUI) - ComfyUI Docker Compose for DGX Spark with SageAttention 2 built against sm_121, NVFP4 via comfy_kitchen, and a copy=False patch for the unified-memory double-VRAM bug.
- [mmartial/ComfyUI-Nvidia-Docker](https://github.com/mmartial/ComfyUI-Nvidia-Docker) - Multi-platform ComfyUI Docker (x86_64, Blackwell, DGX Spark) with published aarch64 DGX images and userscripts that build SageAttention 2 and comfy_kitchen from source.
- [mvalancy/blender-nvidia-gb10](https://github.com/mvalancy/blender-nvidia-gb10) - Blender 5.0.1 source build for GB10 with Cycles CUDA 13 GPU rendering, via four inherited aarch64 patches and four CUDA-13 patches for OIDN, libglu, Wayland, and libdrm.
- [phaserblast/ComfyUI-DGXSparkSafetensorsLoader](https://github.com/phaserblast/ComfyUI-DGXSparkSafetensorsLoader) - Zero-copy model loader for ComfyUI on DGX Spark using the fastsafetensors library.
- [Triplany/comfyui-dgx-spark](https://github.com/Triplany/comfyui-dgx-spark) - Version-aware updater kit for an existing ComfyUI install on DGX Spark, sm_121 SageAttention rebuild, aarch64 cu13 ONNX Runtime wheel, and an LTX 2.3 audio NaN clamp.

## Audio & Speech

- [AEON-7/qwen3-asr-server](https://github.com/AEON-7/qwen3-asr-server) - OpenAI /v1/audio/transcriptions server for Qwen3-ASR-0.6B on DGX Spark, vLLM-native with a pinned flashinfer and a soundfile decode path that avoids the PyAV fallback.
- [briancaffey/nemotron-asr-server](https://github.com/briancaffey/nemotron-asr-server) - Speech-to-text server for DGX Spark with an OpenAI transcriptions API, Nemotron on native NeMo, WebSocket streaming.
- [jxlarrea/homeassistant-voice-recipes](https://github.com/jxlarrea/homeassistant-voice-recipes) - Local Wyoming voice pipeline for Home Assistant, aarch64 ONNX Parakeet ASR, ECAPA-TDNN speaker extraction, and Gemma-4-26B-A4B with MTP on llama.cpp built for sm_121.
- [kedarpotdar-nv/spark-realtime-chatbot](https://github.com/kedarpotdar-nv/spark-realtime-chatbot) - On-device assistant for voice and video calls on one GB10, ~320 ms and ~850 ms end to end, using Qwen3-VL, Kokoro, and DeepFace.
- [Logos-Flux/spark-voice-pipeline](https://github.com/Logos-Flux/spark-voice-pipeline) - WebSocket voice assistant for DGX Spark, sentence-level streaming across whisper.cpp, Ollama, and VibeVoice-Realtime-0.5B, 766 ms to first audio.
- [luka-loehr/qwen3-tts-native](https://github.com/luka-loehr/qwen3-tts-native) - Native Rust and CUDA runtime for Qwen3-TTS-1.7B VoiceDesign on sm_121, 94-96 ms p95 first audio and 5.68 GB peak versus 2.69 s and 108.90 GB for stock SGLang.
- [mARTin-B78/dgx-spark-faster-qwen3-tts](https://github.com/mARTin-B78/dgx-spark-faster-qwen3-tts) - Faster-Qwen3-TTS on DGX Spark as an OpenAI-compatible API with CUDA-graph acceleration, four backends including chunk-streaming, and deterministic per-voice seeds.
- [Mekopa/whisperx-blackwell](https://github.com/Mekopa/whisperx-blackwell) - Prebuilt WhisperX image with an sm_121 to sm_90 capability spoof and torchaudio jiterator patch, GPU pyannote diarization, 24 min audio in 62 s.
- [pipecat-ai/nemotron-voicechat-dgx-spark](https://github.com/pipecat-ai/nemotron-voicechat-dgx-spark) - Full-duplex speech-to-speech NemotronLabs VoiceChat 11B on one DGX Spark, GPTQ W8 Nano and W8A32 EarTTS at ~66 ms against the 80 ms frame budget.
- [Pizzaman213/fish-s2pro-gb10](https://github.com/Pizzaman213/fish-s2pro-gb10) - GB10-tuned Fish Audio S2-Pro TTS reaching 31.3 tok/s from 1.2 via bit-exact int8 kernels, speculative decode, and quality-gated NVFP4 weights.
- [WillIsback/whisperx-gb10](https://github.com/WillIsback/whisperx-gb10) - WhisperX transcription and pyannote diarization REST API for GB10 (aarch64, sm_121), with an async job queue, SRT/VTT/TXT export, and prebuilt Docker Hub/GHCR images on NGC PyTorch 25.05.

## Science & HPC

Beyond LLMs, GB10's unified memory and aarch64 stack run scientific compute: protein folding, biomolecular prediction, and RAN simulation.

- [adrian-greenneuron/openfold3-DGX-Spark](https://github.com/adrian-greenneuron/openfold3-DGX-Spark) - Dockerized OpenFold3 for DGX Spark with evoformer_attn kernels prebuilt, DeepSpeed patched from compute_121 to compute_120, ubiquitin prediction in 55 s.
- [rcbarke/ai-ran-dgx-spark](https://github.com/rcbarke/ai-ran-dgx-spark) - Bring-up notes for NVIDIA Aerial and Sionna on DGX Spark, with Sionna PHY and SYS working, cuMAC retargeted to run, and Sionna-RT and the 7.2x fronthaul blocked.
- [sanjyotshenoy/boltz-gb10-spark](https://github.com/sanjyotshenoy/boltz-gb10-spark) - Boltz-2 biomolecular-interaction prediction on DGX Spark with Triton-nightly sm_121 codegen.

## Remote Access & Desktop

- [eelbaz/dgx-spark-headless-sunshine](https://github.com/eelbaz/dgx-spark-headless-sunshine) - Headless remote desktop setup for DGX Spark using Sunshine streaming.
- [seanGSISG/dgx-spark-sunshine-setup](https://github.com/seanGSISG/dgx-spark-sunshine-setup) - One-command Sunshine installer for headless DGX Spark, NVIDIA CustomEDID virtual display with no dummy plug, 4K60 or 1440p120 within the GB10 pixel clock limit.

## Tools & Monitoring

- [agjs/gb10-clock-cap](https://github.com/agjs/gb10-clock-cap) - Clock-cap harness for GB10 inference hosts: at 2200 MHz, 12 C cooler and 36% less GPU power for 1.0% decode and 3.9% prefill cost.
- [amer8/pulsebar](https://github.com/amer8/pulsebar) - Unofficial macOS menu bar monitor that streams GPU and memory telemetry from the DGX Spark dashboard.
- [antheas/spark_hwmon](https://github.com/antheas/spark_hwmon) - Linux hwmon kernel driver exposing GB10 system power telemetry (per-rail power, energy counters, temperatures) and PL1/PL2 power-cap controls via sysfs.
- [ateska/dgx-spark-prometheus](https://github.com/ateska/dgx-spark-prometheus) - Single-binary Go Prometheus exporter with systemd unit and Grafana dashboard for DGX Spark, GB10 and NIC metrics on port 9835.
- [chappa-ai-llc/spark-smi](https://github.com/chappa-ai-llc/spark-smi) - System-monitor TUI for DGX Spark with unified-memory and Grace P/E-core awareness, a cluster fleet view, an MT2910 fabric bandwidth test, and mixed sm_121 plus sm_86 support.
- [DanTup/dgx_dashboard](https://github.com/DanTup/dgx_dashboard) - Monitoring dashboard for DGX Spark bound to 0.0.0.0, with GB/GiB-correct memory stats, GPU power draw, and Docker container controls.
- [dorangao/dgx-spark-toolkit](https://github.com/dorangao/dgx-spark-toolkit) - Two-node DGX Spark cluster scripts and manifests: RoCE and NCCL checks on the 200 Gb/s fabric, RDMA pods, MetalLB, pipeline-parallel vLLM Nemotron-3 Nano 30B.
- [drowzeys/vllm-gb10-spin-wait-fix](https://github.com/drowzeys/vllm-gb10-spin-wait-fix) - One-command patcher and English write-up for the vLLM spin-wait that heats GB10, up to 24 °C lower SoC temperature at unchanged throughput.
- [engineering87/sparkfit](https://github.com/engineering87/sparkfit) - Zero-dependency memory planner for DGX Spark: 128 GB budget split, quantization advisor, and decode roofline on 273 GB/s.
- [GigCoder-ai/dgxtop](https://github.com/GigCoder-ai/dgxtop) - Terminal hardware monitor for DGX Spark with GB10 GPU, CPU, memory, and per-drive I/O speeds.
- [hectorTSH/dgx-spark-memory-dashboard](https://github.com/hectorTSH/dgx-spark-memory-dashboard) - Live unified-memory occupancy map for DGX Spark as 1 GiB tiles, hot models against on-disk candidates ranked by free memory, and multi-Spark tabs.
- [hoesing/spark-gpu-throttle-check](https://github.com/hoesing/spark-gpu-throttle-check) - Throttle test for DGX Spark that loads the GB10 with cuBLAS matmuls and flags clocks staying below a 1400 MHz threshold, a suspected USB-PD power-delivery fault.
- [jasonacox/dgx-spark](https://github.com/jasonacox/dgx-spark) - Project hub for GB10 whose nanochat scripts pretrained a chat model from scratch in 9 days for about $8 of power, plus two-Spark InfiniBand training.
- [jeffrymahbuubi/dgx-spark-stress-test](https://github.com/jeffrymahbuubi/dgx-spark-stress-test) - Burn-in suite for GB10 unit qualification, 6-24 hour llama.cpp 70B plus SDXL load at ~96% utilization, ~85 GB resident, with 10s temperature and power CSVs.
- [joeynyc/spark-doctor](https://github.com/joeynyc/spark-doctor) - Read-only diagnostic CLI for DGX Spark: 14 W power cap, unified-memory pressure, thermal risk, CUDA 13 / sm_121 wheel mismatches, Docker runtime, and vLLM/Ollama/SGLang recipe checks.
- [lynx-lee/lynx-ollama](https://github.com/lynx-lee/lynx-ollama) - Ollama manager with a Go web console whose optimize command reads GB10 unified memory to set 131K context, 8-way parallel, and q8_0 KV cache.
- [mcampa/sparkrun-ui](https://github.com/mcampa/sparkrun-ui) - Web UI for sparkrun with launch wizard, chat, benchmark charts, and live per-host GPU bars, run via npx or a published aarch64 container.
- [mchenetz/sparkd](https://github.com/mchenetz/sparkd) - Localhost dashboard for a DGX Spark fleet, with HF browsing, Claude-generated vLLM recipes, and single-box or Ray-cluster launch.
- [MiaAI-Lab/sparkDash](https://github.com/MiaAI-Lab/sparkDash) - Web dashboard for a DGX Spark fleet with an engine probe for llama.cpp, vLLM, SGLang, and ds4, 14-day peak tok/s history, and Wake-on-LAN power control.
- [parallelArchitect/sparkview](https://github.com/parallelArchitect/sparkview) - Terminal GPU monitor with GB10-aware unified-memory reporting, memory-pressure (PSI) and power-rail readouts, and an anomaly auto-logger.
- [r0b0tlab/hermes-concurrent-agents](https://github.com/r0b0tlab/hermes-concurrent-agents) - Supervised worker pool for Hermes Agent on one GB10, adding pre-claim admission, exact process ownership, restart reconciliation, and bounded review and rework.
- [securitysonar/spark-hashcat](https://github.com/securitysonar/spark-hashcat) - Hashcat REST API service for GB10 aarch64, with an NVRTC CUDA build path that bypasses OpenCL.
- [TheAwaken1/Spark-Studio](https://github.com/TheAwaken1/Spark-Studio) - Launch and tuning dashboard for vLLM, SGLang, llama.cpp, and sparkrun recipes on DGX Spark that hands a broken recipe to Claude Code or Codex to patch and relaunch.
- [vybe/sparky](https://github.com/vybe/sparky) - Vue 3 web UI for DGX Spark with ComfyUI generation, Ollama chat, voice, and container control.
- [wentbackward/nv-monitor](https://github.com/wentbackward/nv-monitor) - Terminal monitor and Prometheus exporter for DGX Spark in one zero-dependency C binary, with HugePages-correct unified memory and Grace big.LITTLE core labels.

## Operating Systems & Containers

- [graham33/nixos-dgx-spark](https://github.com/graham33/nixos-dgx-spark) - Nix flake with a NixOS module for NVIDIA's DGX Spark kernel, bootable USB image, and 15 playbook devshells for TRT-LLM, NVFP4, and NCCL over QSFP.
- [maxspevack/spark-rocky](https://github.com/maxspevack/spark-rocky) - Rocky Linux 10.2 Live-USB for DGX Spark on the CIQ 6.18 kernel and open driver 610.57.04, carrying zero patches of its own and validated at 1.010x benchmark parity.
- [Neural-ICE/ICE-CoreOS](https://github.com/Neural-ICE/ICE-CoreOS) - Immutable bootc OS for DGX Spark on CentOS Stream 10, GB10 kernel at 4 KiB pages, TPM2-unlocked LUKS2, and atomic over-the-air updates with rollback from a signed registry.
- [RageLtd/arch-dgx-spark-iso](https://github.com/RageLtd/arch-dgx-spark-iso) - Arch Linux installer ISO builder for DGX Spark, with the linux-dgx-spark kernel and archinstall config.
- [scitrera/cuda-containers](https://github.com/scitrera/cuda-containers) - Prebuilt DGX Spark containers for vLLM, SGLang, llama.cpp, and PyTorch that build NCCL and PyTorch first as a base layer and version by vLLM release rather than tracking git.

## Community & Resource Collections

- [AEON-7/AEON-7](https://github.com/AEON-7/AEON-7) - Index of AEON-7's DGX Spark releases: NVFP4 model packs, prebuilt vLLM images, and a voice-AI stack.
- [jeremyeder/dgx-agentskills](https://github.com/jeremyeder/dgx-agentskills) - Claude Code integration for DGX Spark: local model serving, GPU monitoring, and VM management.
- [odnodn/dgx-spark](https://github.com/odnodn/dgx-spark) - Curated collection of NVIDIA DGX Spark resources and self-hosted AI projects.

## Contributing

Contributions are welcome. Read the [contribution guidelines](contributing.md) before opening a pull request.
