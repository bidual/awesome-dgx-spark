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

- [NVIDIA/dgx-spark-playbooks](https://github.com/NVIDIA/dgx-spark-playbooks) - Official step-by-step playbooks for DGX Spark spanning vLLM, SGLang, llama.cpp, ComfyUI, cuTile kernels, JAX, Isaac Sim and Lab, LLaMA Factory, and two- and three-node topologies.

## Setup & Configuration

- [a1exus/sparky](https://github.com/a1exus/sparky) - Self-hosted DGX Spark LLM stack with vLLM, llama.cpp, and Ollama behind Traefik and three-path ingress.
- [Albatross1382/onnxruntime-aarch64-cuda-blackwell](https://github.com/Albatross1382/onnxruntime-aarch64-cuda-blackwell) - ONNX Runtime 1.24.4 shared libraries with CUDA execution provider for DGX Spark sm_121 on aarch64.
- [botAGI/AGmind](https://github.com/botAGI/AGmind) - One-command private RAG stack for DGX Spark (aarch64/GB10), with dual-Spark cluster support and 30+ containers.
- [Chrizz-lab/GB10-Agentig-Coding-Framework](https://github.com/Chrizz-lab/GB10-Agentig-Coding-Framework) - Agentic coding stack for DGX Spark with dual-vLLM Qwen3 and CrewAI orchestration.
- [csabakecskemeti/dgx-spark-community-playbooks](https://github.com/csabakecskemeti/dgx-spark-community-playbooks) - Community playbook collection for DGX Spark, covering dual-Spark RDMA inference, heterogeneous RoCE clustering, and local Claude Code.
- [getainode/ainode](https://github.com/getainode/ainode) - Browser-UI AI appliance for GB10 doing both inference and LoRA fine-tuning, with UDP-discovered multi-Spark tensor-parallel clustering verified on a 4-node 487 GB cluster.
- [GuigsEvt/dgx_spark_config](https://github.com/GuigsEvt/dgx_spark_config) - Source-build guide for the DGX Spark software stack, walking LLVM, a Triton wheel, and PyTorch from scratch against the GB10 Grace-Blackwell libraries.
- [HeKun-NVIDIA/dgx-spark-openclaw](https://github.com/HeKun-NVIDIA/dgx-spark-openclaw) - One-command deploy of a local LLM plus OpenClaw agent frontend on DGX Spark, using a GB10 NVFP4-kernel vLLM image.
- [HendrikSchoettle/ragflow-dgx-spark](https://github.com/HendrikSchoettle/ragflow-dgx-spark) - Build and deploy pipeline for RAGFlow v0.24.0 on DGX Spark aarch64, with a source-built onnxruntime-gpu wheel for sm_121 and multilingual OCR.
- [install-safe-press/gb10-playbooks](https://github.com/install-safe-press/gb10-playbooks) - Chinese-language walkthrough of NVIDIA's 30-plus official GB10 playbooks, one directory each, with added hardware, networking, and clustering notes and a companion video series.
- [JetBrains-Hardware/spark-setup](https://github.com/JetBrains-Hardware/spark-setup) - DGX Spark setup and vLLM deployment scripts for Qwen, GPT-OSS, and Nemotron 3.
- [jl-codes/dgx-spark-ai](https://github.com/jl-codes/dgx-spark-ai) - Curriculum for running GPT-OSS 120B on DGX Spark with unified-memory architecture lessons.
- [m9h/neurocontainers-arm](https://github.com/m9h/neurocontainers-arm) - Prebuilt causal-conv1d and mamba-ssm aarch64 wheels plus aarch64 neuroimaging containers built against NGC PyTorch CUDA 13, with the NeuroSTORM Mamba stack verified on DGX Spark.
- [mARTin-B78/dgx-spark_lite-llm_llama-swap_vllm_llama-cpp_ollama](https://github.com/mARTin-B78/dgx-spark_lite-llm_llama-swap_vllm_llama-cpp_ollama) - Multi-engine LLM stack for DGX Spark with llama-swap VRAM eviction and a LiteLLM gateway, tiered for GB10's 128 GB unified memory.
- [natolambert/dgx-spark-setup](https://github.com/natolambert/dgx-spark-setup) - Setup guide focused on ML training (GB10 Blackwell, CUDA 13, aarch64).
- [seitzbg/onnxruntime-gpu-sm121-aarch64](https://github.com/seitzbg/onnxruntime-gpu-sm121-aarch64) - Prebuilt onnxruntime-gpu 1.27.1 wheel for aarch64 with a CUDA 13 execution provider compiled for sm_121, against cuDNN 9.
- [Sggin1/DGX-SPARK](https://github.com/Sggin1/DGX-SPARK) - Research and tests with containers and benchmarks for GB10 (SM 12.1).
- [sjug/dgx-spark-ethernet-patch](https://github.com/sjug/dgx-spark-ethernet-patch) - Binary patch for the DGX Spark OOBE ethernet-detection bug, an 8-byte aarch64 HasInternet edit for FastOS 1.120.38.
- [Th0rgal/cuda-blackwell-carry-bug](https://github.com/Th0rgal/cuda-blackwell-carry-bug) - Repro for a PTXAS bug that drops the carry flag between separate inline-asm blocks on GB10 sm_121, correct on sm_89, with a builtin-based workaround.
- [theshiphq/claw-spark](https://github.com/theshiphq/claw-spark) - One-command OpenClaw and Ollama agent for DGX Spark at ~59 tok/s on Qwen3.5-35B-A3B.
- [timothystewart6/ubuntu-gb10](https://github.com/timothystewart6/ubuntu-gb10) - Ubuntu 24.04 setup guide for GB10 running standard Ubuntu Server instead of DGX OS, covering DGX Spark and ASUS/Lenovo/Dell partner units.

## Inference & Serving

### vLLM

- [AEON-7/vllm-dflash](https://github.com/AEON-7/vllm-dflash) - DGX Spark vLLM image wiring DFlash speculative decoding and NVFP4, 64 tok/s single-stream on GB10.
- [AEON-7/vllm-ultimate-dgx-spark](https://github.com/AEON-7/vllm-ultimate-dgx-spark) - DGX Spark vLLM 0.22.1 image with Triton NVFP4 KV cache (3x capacity), DFlash, and four sm_121a patches.
- [airawatraj/dgx-spark-nemotron-super-agent](https://github.com/airawatraj/dgx-spark-nemotron-super-agent) - Nemotron-3-Super-120B agentic stack on DGX Spark with tool-calling and spark-arena 23.7 tok/s.
- [Anemll/dspark-vllm-gx10](https://github.com/Anemll/dspark-vllm-gx10) - Two-node GB10 port of DeepSeek-V4-Flash DSpark to vLLM 0.25.1, adding nvfp4_ds_mla as a first-class KV format and a b12x MXFP4 MoE backend.
- [atcuality2021/vllm-gb10-gemma4](https://github.com/atcuality2021/vllm-gb10-gemma4) - Gemma 4 backport for DGX Spark with GB10 fixes: sm_121 NCCL build, CUTLASS FP8 disable, Ray unified-memory.
- [Avarok-Cybersecurity/dgx-vllm](https://github.com/Avarok-Cybersecurity/dgx-vllm) - vLLM image for DGX Spark with a custom NVFP4 kernel at 20% over AWQ INT4, peaking at 111.9 tok/s on an 80B model with MTP speculative decoding.
- [bjk110/spark_vllm_docker](https://github.com/bjk110/spark_vllm_docker) - vLLM serving for DGX Spark spanning single-box TP=1 and dual-Spark TP=2 over 200 Gb/s RoCE, with sm_121 FP8 and NVFP4 patches.
- [drowzeys/Keys-Concurrency-Patch-for-DSpark-DeepSeek-V4-Flash](https://github.com/drowzeys/Keys-Concurrency-Patch-for-DSpark-DeepSeek-V4-Flash) - vLLM patch unlocking continuous-batch concurrency for DSpark speculative decoding (stock serializes at max-num-seqs 1), with byte-identical single-stream output and 122 tok/s at concurrency 4 on dual DGX Spark TP=2.
- [EmilHaase/DGX-Spark-VLLM-Hydra-Manager](https://github.com/EmilHaase/DGX-Spark-VLLM-Hydra-Manager) - vLLM manager for DGX Spark with sm_121a source builds and UMA KV-cache limits for multi-model launch.
- [Entrpi/ds4-spark-vllm](https://github.com/Entrpi/ds4-spark-vllm) - 2-bit DeepSeek-V4-Flash vLLM serving on a single DGX Spark, with KV-layout fork patches raising concurrency to 229x.
- [eugr/spark-vllm-docker](https://github.com/eugr/spark-vllm-docker) - vLLM Docker for one to N DGX Sparks over Ray or native PyTorch distributed, covering direct dual links, RoCE switches, and 3-node mesh, with fastsafetensors and InstantTensor loading.
- [jordanovski/overdrive](https://github.com/jordanovski/overdrive) - Async TUI, CLI, and web orchestrator for launching, monitoring, and benchmarking concurrent vLLM instances on DGX Spark via NGC containers.
- [mark-ramsey-ri/vllm-dgx-spark](https://github.com/mark-ramsey-ri/vllm-dgx-spark) - Run vLLM on 1-to-N DGX Spark servers (single Spark, 2 via direct cable, or 3+ via switched fabric) to serve or benchmark LLMs.
- [omnia-projetcs/spark-dgx](https://github.com/omnia-projetcs/spark-dgx) - Interactive vLLM Docker launcher for DGX Spark with per-model NVFP4/FP8 configs across a 20+ model catalog.
- [phuongncn/asus-gx10-qwen35-speed-hack](https://github.com/phuongncn/asus-gx10-qwen35-speed-hack) - One-shell-script hybrid INT4+FP8 + MTP vLLM setup for Qwen3.5 on ASUS GX10 / DGX Spark, 35B 30 to 112 tok/s.
- [saifgithub/vllm-gb10-sm121](https://github.com/saifgithub/vllm-gb10-sm121) - vLLM FP8 CUTLASS and NVFP4 dispatch patch for GB10 sm_121, with the sm120-only arch guard removed.
- [Sapid-Labs/vllm-spark-arena](https://github.com/Sapid-Labs/vllm-spark-arena) - Crowd-optimization arena for vLLM on sm_121, scoring each submitted patch as a paired ratio on real DGX Spark hardware and gating on byte-identical output.
- [spark-arena/sparkrun](https://github.com/spark-arena/sparkrun) - One-command launcher for LLM workloads across one or more DGX Sparks, installed from PyPI, with a wizard that builds the SSH mesh, detects ConnectX-7, and enables earlyoom.
- [technigmaai/dgx-spark](https://github.com/technigmaai/dgx-spark) - vLLM serving recipes for Qwen3.6 (PrismaQuant and NVFP4) on DGX Spark, with chat-template fixes and benchmark notes.
- [timothystewart6/vllm-gb10](https://github.com/timothystewart6/vllm-gb10) - Docker image for DGX Spark with the full vLLM stack pinned by commit SHA or digest.

### llama.cpp

- [croll83/llama.cpp-dgx](https://github.com/croll83/llama.cpp-dgx) - Fork of llama.cpp optimized for DGX Spark with NVFP4, TurboQuant, and DFlash MTP.
- [phuongncn/qwen3.6-27b-speedhack-gx10-dgx-spark](https://github.com/phuongncn/qwen3.6-27b-speedhack-gx10-dgx-spark) - DFlash block-diffusion spec-decode llama.cpp for Qwen3.6-27B on DGX Spark (GB10), 7 to 38 tok/s coding via p_min drafting.
- [Sapid-Labs/llamacpp-spark-arena](https://github.com/Sapid-Labs/llamacpp-spark-arena) - Crowd-optimization arena for llama.cpp CUDA kernels on sm_121, with a thermal gate, alternating baseline and candidate runs, and referee-verified held-out speedup.
- [shamily/gemma4-llama-dgx-spark](https://github.com/shamily/gemma4-llama-dgx-spark) - Dockerized Gemma 4 inference with llama.cpp for GB10 (aarch64 + CUDA 13).
- [ZengboJamesWang/Qwen3.5-35B-A3B-openclaw-dgx-spark](https://github.com/ZengboJamesWang/Qwen3.5-35B-A3B-openclaw-dgx-spark) - Run Qwen3.5-35B-A3B with llama.cpp and openclaw on DGX Spark (GB10).

### SGLang

- [BTankut/dgx-spark-sglang-moe-configs](https://github.com/BTankut/dgx-spark-sglang-moe-configs) - SGLang MoE kernel configs for DGX Spark (GLM-4.7-FP8).
- [InquiringMinds-AI/longcat-next-multimodal](https://github.com/InquiringMinds-AI/longcat-next-multimodal) - LongCat-Next 75B any-to-any multimodal served through one SGLang process on a single GB10, at w8a8_int8 after 4-bit collapsed image and audio generation.
- [mark-ramsey-ri/sglang-dgx-spark](https://github.com/mark-ramsey-ri/sglang-dgx-spark) - Run SGLang on 1-to-N DGX Spark servers (single Spark, 2 via direct cable, or 3+ via switched fabric) to serve or benchmark LLMs.
- [robbiemu/dgx-spark-inference](https://github.com/robbiemu/dgx-spark-inference) - SGLang serving platform for DGX Spark with memory-budget admission control for co-resident unified-memory models.
- [scottgl9/sglang-spark-gb10-optimizations](https://github.com/scottgl9/sglang-spark-gb10-optimizations) - SGLang fork that gets NVFP4 models running on sm_121 (Marlin FP4 path around broken CUTLASS FP4) plus GB10 unified-memory tuning, with MTP decode benchmarks.
- [ubehera/sglang-spark](https://github.com/ubehera/sglang-spark) - SGLang runtime for DGX Spark with an sm_121a-native sgl-kernel wheel and NCCL 2.30.4 sm_121 cubins.

### Other Engines

- [antirez/ds4](https://github.com/antirez/ds4) - DwarfStar local inference engine in C for DeepSeek V4 Flash and GLM 5.2, with a `make cuda-spark` target and published GB10 numbers of 826 t/s prefill and 18.1 t/s decode.
- [Avarok-Cybersecurity/atlas](https://github.com/Avarok-Cybersecurity/atlas) - Pure-Rust LLM inference engine with a dedicated GB10/Spark hardware target, KV-cache quantization, and a pluggable model and hardware abstraction.
- [blake-snc/sm121-kernels](https://github.com/blake-snc/sm121-kernels) - Hand-written PTX kernel library for sm_121 in 259 files, covering flash attention, GEMM, Gated DeltaNet, and MoE, driver-only via cudarc with FP8 attention at ~108 TFLOPS.
- [calico88x/DGX-Model-Manager](https://github.com/calico88x/DGX-Model-Manager) - Single-file web UI for managing Ollama, SGLang, vLLM, llama.cpp, LocalAI, and ComfyUI on DGX Spark.
- [jdaln/dgx-spark-inference-stack](https://github.com/jdaln/dgx-spark-inference-stack) - Docker serving stack for a single DGX Spark with on-demand model loading, automatic idle shutdown, and a unified API gateway.
- [joshhu/meetaclawtaipei](https://github.com/joshhu/meetaclawtaipei) - Three concurrent NVFP4 vLLM models on one DGX Spark with a 3-LLM voice-clone roommate demo.
- [kshetrajna12/sparkstation](https://github.com/kshetrajna12/sparkstation) - LLM gateway for DGX Spark fronting vLLM, SGLang, and TRT-LLM under one OpenAI-compatible API, with auto-suspend and thermal protection.
- [lrozewicz/vLLM-Moet-GB10](https://github.com/lrozewicz/vLLM-Moet-GB10) - vLLM-Moet fork for one GB10, running DeepSeek-V4-Flash 304B at ~9.8 tok/s and 256K context via 2-bit expert planes with an FP4 delta tier.
- [mark-ramsey-ri/trt-dgx-spark](https://github.com/mark-ramsey-ri/trt-dgx-spark) - TensorRT-LLM serving on 1-to-N DGX Spark with an arm64 nvcr 1.2.1 container and tensor-parallel auto-scaling to cluster size.
- [rdoiron/mimo-mods-for-dgx-spark](https://github.com/rdoiron/mimo-mods-for-dgx-spark) - Ten vLLM runtime patches for MiMo-V2.5 on sm_121a, with a CUTLASS block-FP8 bypass and a backported tool-call corruption fix (PR #42969).
- [re-cinq/minimax-m2.5-nvidia-dgx](https://github.com/re-cinq/minimax-m2.5-nvidia-dgx) - MiniMax-M2.5 (230B-A10B) GGUF inference server for DGX Spark via llama.cpp Docker Compose, with an OpenCode agent frontend.
- [sf-stav/veloGB10](https://github.com/sf-stav/veloGB10) - Rust and CUDA inference engine built only for GB10, running Qwen3.6-35B at ~111 tok/s on one machine and ~130 on two over ConnectX-7, with prebuilt binaries.
- [Th0rgal/dgx-spark-router](https://github.com/Th0rgal/dgx-spark-router) - Zero-dependency OpenAI-compatible router for DGX Spark that swaps llama.cpp and vLLM NVFP4 backends in-place to fit 128 GB unified memory.
- [xangel82/DS4-GB10-GX10-DSpark-CUDA](https://github.com/xangel82/DS4-GB10-GX10-DSpark-CUDA) - ds4 fork for one GB10 with sm_121a sparse-attention and routed-MoE prefill kernels, at 900-953 t/s prefill and 24-26 t/s DSpark decode against ~13 on the original CUDA path.

## Fine-tuning

- [albond/DGX_Spark_Unsloth_Lossless_Speedup](https://github.com/albond/DGX_Spark_Unsloth_Lossless_Speedup) - Unsloth optimizations for Qwen3.5 fine-tuning on DGX Spark, reaching 7.67x LoRA / 8.35x full fine-tune speedups with a bit-identical loss curve.
- [alicankiraz1/DGX-Spark-Asus-Ascent-Nvidia-GB10-SFT-Finetuner](https://github.com/alicankiraz1/DGX-Spark-Asus-Ascent-Nvidia-GB10-SFT-Finetuner) - No-code SFT fine-tuning tool for DGX Spark.
- [haven-jeon/unsloth-vllm-gb10](https://github.com/haven-jeon/unsloth-vllm-gb10) - Unsloth training and vLLM inference Docker image for DGX Spark GB10 with source-built xformers and Triton.
- [kreuzhofer/dgx-spark-unsloth-qwen3.5-training](https://github.com/kreuzhofer/dgx-spark-unsloth-qwen3.5-training) - BF16 LoRA fine-tuning of Qwen3.5-35B-A3B on a single DGX Spark with unsloth.
- [NvMayMay/nvfp4-lora-spark](https://github.com/NvMayMay/nvfp4-lora-spark) - LoRA trained directly on the served NVFP4 weights of a 100B+ MoE on one GB10, with a manifest fingerprint that catches a bad merge silently serving the un-adapted base.
- [ubehera/finetune](https://github.com/ubehera/finetune) - Unsloth LoRA fine-tune for GB10 with five sm_121/aarch64 hotfixes for xformers and torchvision.
- [waybarrios/dgx-spark-finetune-llm](https://github.com/waybarrios/dgx-spark-finetune-llm) - LLM fine-tuning with LoRA + NVFP4/MXFP8 on DGX Spark.

## Quantization & NVFP4

GB10's Blackwell architecture supports NVFP4 (4-bit floating point) in hardware. It runs faster than INT4 at similar quality.

- [AEON-7/Gemma-4-26B-A4B-it-Uncensored-NVFP4](https://github.com/AEON-7/Gemma-4-26B-A4B-it-Uncensored-NVFP4) - NVFP4 Gemma 4 26B MoE on DGX Spark with DFlash speculative decoding, 39-155 tok/s single-stream.
- [AEON-7/Gemma-4-31B-Uncensored-NVFP4-DFlash](https://github.com/AEON-7/Gemma-4-31B-Uncensored-NVFP4-DFlash) - vLLM image for DGX Spark serving NVFP4 Gemma 4 31B (Deckard Heretic) with z-lab DFlash speculative decoding.
- [AEON-7/Nemotron-3-Nano-Omni-AEON-Ultimate-Uncensored](https://github.com/AEON-7/Nemotron-3-Nano-Omni-AEON-Ultimate-Uncensored) - Source-built vLLM image for DGX Spark serving abliterated Nemotron-3-Nano-Omni multimodal in BF16 and NVFP4.
- [AEON-7/Ornith-1.0-35B-AEON-Ultimate-Uncensored](https://github.com/AEON-7/Ornith-1.0-35B-AEON-Ultimate-Uncensored) - Abliterated Ornith-1.0-35B (DeepReinforce agentic-coding MoE) in BF16 and NVFP4, 93 vs 30 tok/s decode on DGX Spark with DFlash, at 0/80 refusals and unchanged 0.833 agentic pass@1.
- [AEON-7/Qwen3.6-27B-AEON-Ultimate-Uncensored-DFlash](https://github.com/AEON-7/Qwen3.6-27B-AEON-Ultimate-Uncensored-DFlash) - Prebuilt vLLM container for DGX Spark with abliterated Qwen3.6-27B (NVFP4 + DFlash), sm_121a-patched for 37.6 tok/s vs 10.5 raw.
- [AEON-7/Qwen3.6-NVFP4-DFlash](https://github.com/AEON-7/Qwen3.6-NVFP4-DFlash) - Source-built vLLM image with 7 sm_121a patches serving NVFP4 Qwen3.6-35B-A3B at 84 tok/s with DFlash speculative decoding.
- [AEON-7/supergemma4-26b-abliterated-multimodal-nvfp4](https://github.com/AEON-7/supergemma4-26b-abliterated-multimodal-nvfp4) - NVFP4 (AWQ) SuperGemma4-26B abliterated multimodal for DGX Spark, as a prebuilt vLLM container.
- [BioInfo/turboquant-dgx](https://github.com/BioInfo/turboquant-dgx) - TurboQuant KV-cache quantization on GB10 with 3.88x compression and 8.4x Triton kernel speedup.
- [drowzeys/vLLm-0.24-optimized-NVIDIA-Nemotron-Lab-Puzzle-75B-A9B-A4Q-MTP3-NVFP4-KV-2.7M-Pool-Single-DGX-Spark](https://github.com/drowzeys/vLLm-0.24-optimized-NVIDIA-Nemotron-Lab-Puzzle-75B-A9B-A4Q-MTP3-NVFP4-KV-2.7M-Pool-Single-DGX-Spark) - Nemotron-Labs-3 Puzzle-75B-A9B on a single DGX Spark with A4Q NVFP4 attention, 25.8 tok/s decode.
- [jethac/vllm-nvfp4-kv-consumer-blackwell-repro](https://github.com/jethac/vllm-nvfp4-kv-consumer-blackwell-repro) - One-command repro for the vLLM NVFP4 KV V-scale swizzle bug on sm_121, showing corrupted versus fixed output and 3.4-3.6x KV capacity over BF16.
- [localai-org/apex-quant](https://github.com/localai-org/apex-quant) - MoE-aware mixed-precision GGUF quant recipe, quality and throughput benchmarked on GB10.
- [Logos-Flux/optimized-CUDA-GB10](https://github.com/Logos-Flux/optimized-CUDA-GB10) - CUDA kernels (RMSNorm, GELU) for GB10 sm_121, the first sm_121 kernels on the Hugging Face Kernel Hub.
- [mitkox/sparser-faster-llms](https://github.com/mitkox/sparser-faster-llms) - GB10 sm_121 CUDA-core TwELL sparse-kernel port of SakanaAI's sparser-faster-llms for DGX Spark builds without Hopper WGMMA.
- [Plaaasma/FlashQLA-Blackwell](https://github.com/Plaaasma/FlashQLA-Blackwell) - Qwen's FlashQLA TileLang Gated Delta Net kernels ported to GB10 (sm_121), dropping into vLLM as a faster prefill kernel for Qwen3.6 linear-attention models.
- [r0b0tlab/gemma4-26b-a4b-nvfp4-gb10-native-cutlass](https://github.com/r0b0tlab/gemma4-26b-a4b-nvfp4-gb10-native-cutlass) - Gemma-4-26B-A4B NVFP4 for GB10 via native VLLM_CUTLASS MoE backend on CUDA-13 nightly, 260 tok/s at concurrency 8.
- [r0b0tlab/gemma4-31b-it-nvfp4-gb10](https://github.com/r0b0tlab/gemma4-31b-it-nvfp4-gb10) - Gemma-4-31B-IT NVFP4 reproducibility pack for GB10 with native FlashInfer/CUTLASS FP4 GEMM, 54 tok/s at concurrency 8.
- [r0b0tlab/nemotron3-super-120b-a12b-nvfp4-gb10-native-mtp](https://github.com/r0b0tlab/nemotron3-super-120b-a12b-nvfp4-gb10-native-mtp) - Nemotron-3-Super-120B-A12B NVFP4 for GB10 on SGLang native MTP, 21.64 tok/s and +45.8% over baseline.
- [r0b0tlab/nvidia-qwen-3.6-27B-sm121-nvfp4](https://github.com/r0b0tlab/nvidia-qwen-3.6-27B-sm121-nvfp4) - Qwen3.6-27B NVFP4 serving pack for GB10 (sm_121) with vLLM native MTP and FP8 KV cache, 144 tok/s at concurrency 16 and 81.88% full-set GSM8K.
- [r0b0tlab/qwen36-35b-a3b-nvfp4-fast-sm121-vllm](https://github.com/r0b0tlab/qwen36-35b-a3b-nvfp4-fast-sm121-vllm) - Qwen3.6-35B-A3B NVFP4-Fast on one GB10 via sm_121-native vLLM, 80.6 tok/s single-stream to 344 tok/s at concurrency 32, with GSM8K 86.73% and 86.33% MTP acceptance over 474K draft tokens.
- [RobTand/gridbook](https://github.com/RobTand/gridbook) - Product-codebook weight format and out-of-tree vLLM plugin whose decoded tiles are native NVFP4 or FP8, serving a 295B MoE at 2.9 bpp on one DGX Spark.
- [secYOUre/nvfp4bench](https://github.com/secYOUre/nvfp4bench) - NVFP4 peak-throughput CLI for GB10 sm_121a, 1022 TFLOPS sparse and 511 dense via packed mxf4nvf4 MMA.
- [spped2000/thaillm-nvfp4-dgx-spark](https://github.com/spped2000/thaillm-nvfp4-dgx-spark) - ThaiLLM-30B NVFP4 study on DGX Spark, 3.4x smaller, 63 tok/s decode, Thai accuracy statistically unchanged.
- [sudoingX/dgx-spark-laguna](https://github.com/sudoingX/dgx-spark-laguna) - Laguna S 2.1 NVFP4 on DGX Spark with DFlash, 25-30 tok/s at 128K, plus hard-hang protection.
- [vladimir-voinea/gb10-laguna-s-2.1-w4a16-moe](https://github.com/vladimir-voinea/gb10-laguna-s-2.1-w4a16-moe) - W4A16 grouped-MoE kernels and GB10-tuned Triton configs for sm_121a, targeting the LPDDR5X roofline that Marlin misses at 10.8 tok/s on a 117B MoE.

## Models & Benchmarks

- [adadrag/qwen3.5-dgx-spark](https://github.com/adadrag/qwen3.5-dgx-spark) - Guide to running Qwen3.5-35B-A3B on DGX Spark (GB10) with vLLM: installation, benchmarks, vision features, and troubleshooting.
- [albond/DGX_Spark_Qwen3.5-122B-A10B-AR-INT4](https://github.com/albond/DGX_Spark_Qwen3.5-122B-A10B-AR-INT4) - Qwen3.5-122B-A10B on DGX Spark, tuned from 28.3 to 51 tok/s (+80%).
- [Avarok-Cybersecurity/atlas-recipes](https://github.com/Avarok-Cybersecurity/atlas-recipes) - Sparkrun recipe registry for the Atlas engine on GB10, 15+ NVFP4 models with validated KV/MoE settings and per-model tok/s.
- [Blackwellboy/laguna-s21-lab](https://github.com/Blackwellboy/laguna-s21-lab) - Testing lab for Laguna S 2.1 NVFP4 on one DGX Spark, publishing a 20-cell tuning sweep with its losing cells and a 12-hour soak over 3,099 turns.
- [casualcomputer/rtx_pro_6000_vs_dgx_spark](https://github.com/casualcomputer/rtx_pro_6000_vs_dgx_spark) - DGX Spark vs RTX PRO 6000 inference benchmark with memory-bandwidth analysis across batch sizes.
- [DanTup/spark-evals](https://github.com/DanTup/spark-evals) - Accuracy evals (BFCL, BigCodeBench, IFEvalCode) for models and quantizations that fit on a single DGX Spark, as a leaderboard.
- [elsung/dgx-spark-deepseek-v4-flash](https://github.com/elsung/dgx-spark-deepseek-v4-flash) - Cross-machine DeepSeek-V4-Flash benchmark for dual DGX Spark, with a 10-model GGUF suite and 500K long-context decay curves.
- [Entrpi/ds4-on-spark](https://github.com/Entrpi/ds4-on-spark) - DGX Spark fork of antirez/ds4 at 2.4-3.3x upstream prefill and 1.33-1.47x decode, adding continuous batching at 59 tok/s over 12 concurrent requests and prefix caching that cuts warm TTFT ~7x.
- [Entrpi/qwen3.5-122B-A10B-on-spark](https://github.com/Entrpi/qwen3.5-122B-A10B-on-spark) - Qwen3.5-122B-A10B on a single DGX Spark via DFlash block-diffusion spec-decode, 81 tok/s on agent traffic.
- [GaelicThunder/gb10-uma-inference-notes](https://github.com/GaelicThunder/gb10-uma-inference-notes) - Five measured GB10 unified-memory properties that hold across models and engines, including host-to-device copies as pure waste worth 63% once removed.
- [GaelicThunder/moe-offload-findings](https://github.com/GaelicThunder/moe-offload-findings) - Nine findings on MoE decode with experts streamed from NVMe, mostly negative: batching does not amortize expert reads and prefetching cannot beat a static pin.
- [jeremy-newhouse/dgx-spark-nemotron-super-bench](https://github.com/jeremy-newhouse/dgx-spark-nemotron-super-bench) - Single-stream decode benchmark of Nemotron-3-Super-120B-A12B-NVFP4 on one GB10, ~26-27 tok/s realistic with MTP vs ~33.6 microbench.
- [jvr0x/dgx-spark-bench](https://github.com/jvr0x/dgx-spark-bench) - Concurrency-sweep LLM benchmark for DGX Spark with per-session and aggregate tok/s and recipe-pinned provenance.
- [Kleybrink/dgx-spark-bench](https://github.com/Kleybrink/dgx-spark-bench) - Benchmarking framework measuring throughput, latency, VRAM, and accuracy with LLM-as-a-Judge.
- [marksunner/dgx-spark-single-stack](https://github.com/marksunner/dgx-spark-single-stack) - Qwen3.5-122B on a single DGX Spark at 41-47 tok/s via a hybrid INT4+FP8 checkpoint with MTP speculative decoding, benchmarked against a dual-Spark Ray setup that trails at ~28 tok/s.
- [marksunner/dgx-spark-step37-flash](https://github.com/marksunner/dgx-spark-step37-flash) - Notes on running StepFun's Step 3.7 Flash (198B MoE) on a single DGX Spark with llama.cpp at ~27 tok/s and 128K context.
- [martimramos/dgx-spark-ml-guide](https://github.com/martimramos/dgx-spark-ml-guide) - Guide to running PyTorch and ML workloads on DGX Spark.
- [Memoriant/dgx-spark-kv-cache-benchmark](https://github.com/Memoriant/dgx-spark-kv-cache-benchmark) - KV cache quantization on GB10: dequantization cliff (q4_0 −37% gen tps at 110K), unified-memory paradox, prefill immunity.
- [nabe2030/dense-27b-31b-dgx-spark](https://github.com/nabe2030/dense-27b-31b-dgx-spark) - Benchmark of Qwen 3.5/3.6-27B and Gemma 4-31B on DGX Spark.
- [nabe2030/gemma4-vs-qwen35-dgx-spark](https://github.com/nabe2030/gemma4-vs-qwen35-dgx-spark) - Gemma 4 vs Qwen 3.5 MoE benchmark with llama.cpp.
- [OscarActual/gb10-llm-benchmark](https://github.com/OscarActual/gb10-llm-benchmark) - Ollama benchmarks for GB10 across 11 LLMs and 10 embedders: decode tok/s, TTFT, and Czech RAG recall.
- [pendakwahteknologi/gx10-benchmarks](https://github.com/pendakwahteknologi/gx10-benchmarks) - Fifteen-benchmark suite for the ASUS Ascent GX10 (GB10) spanning inference, training, efficiency, image and video generation, voice, and multimodal.
- [r0b0tlab/deepseek-v4-flash-nvfp4-gb10-benchmark](https://github.com/r0b0tlab/deepseek-v4-flash-nvfp4-gb10-benchmark) - DeepSeek-V4-Flash FP8 benchmark on dual DGX Spark (sm_121a, TP=2, RoCE, MTP), 7.5x to 38 tok/s from build-commit pinning.
- [r0b0tlab/diffusiongemma-26b-nvfp4-sm121-vllm](https://github.com/r0b0tlab/diffusiongemma-26b-nvfp4-sm121-vllm) - vLLM container and benchmark for DiffusionGemma 26B-A4B NVFP4 on GB10 via native CUTLASS FP4 MoE.
- [r0b0tlab/laguna-s-2.1-nvfp4-sm121-vllm](https://github.com/r0b0tlab/laguna-s-2.1-nvfp4-sm121-vllm) - Laguna S 2.1 NVFP4 on GB10 pinned to an exact checkpoint revision, with DFlash K=7 at 22.2 tok/s and an 8,620-case scorecard behind a checksummed verdict.
- [r0b0tlab/minimax-m27-nvfp4-gb10-benchmark](https://github.com/r0b0tlab/minimax-m27-nvfp4-gb10-benchmark) - MiniMax-M2.7 NVFP4 benchmark on dual GB10 (sm_121) via vLLM FlashInfer-CUTLASS, 25.06 tok/s tg128 with an arm64 image.
- [r0b0tlab/nex-n2-mini-nvfp4](https://github.com/r0b0tlab/nex-n2-mini-nvfp4) - NVFP4 vLLM container for Nex-N2-mini (Qwen3.5-MoE-35B) on GB10, 185 tok/s aggregate at concurrency 8.
- [r0b0tlab/step37-flash-nvfp4-sm121-vllm-docker](https://github.com/r0b0tlab/step37-flash-nvfp4-sm121-vllm-docker) - vLLM container for StepFun's Step 3.7 Flash NVFP4 (198B MoE VLM) on dual GB10 TP=2, with verified native-CUTLASS sm_121 execution at 16.49 tok/s.
- [rossingram/Spark-DGX-Benchmark](https://github.com/rossingram/Spark-DGX-Benchmark) - Benchmark script testing compute, memory bandwidth, diffusion, and LLM throughput on DGX Spark.
- [VincentMarquez/glm52-gb10-colibri](https://github.com/VincentMarquez/glm52-gb10-colibri) - GLM-5.2 744B on a single DGX Spark at 11.1 tok/s decode with full top-8 routing, via the colibri engine's CACHE_ROUTE expert residency and GPU MLA.
- [Weschera/spark-bench](https://github.com/Weschera/spark-bench) - LLM benchmark for DGX Spark across 76 scenarios and 12 domains, with 12 multi-turn agentic workflows and a TrueScore weighting that puts speed at 5%.
- [yunusshin/DGX_Spark_Qwen3.5-35B-A3B-Optimized](https://github.com/yunusshin/DGX_Spark_Qwen3.5-35B-A3B-Optimized) - Qwen3.5-35B-A3B optimizations for DGX Spark: INT8 lm_head and MTP-2, 64 to 113 tok/s.

## Multi-node

You can connect two DGX Spark units directly over 200 Gb/s QSFP for double the memory and compute.

- [0xdfi/GLM-5.2-1M-4x-DGX-Spark](https://github.com/0xdfi/GLM-5.2-1M-4x-DGX-Spark) - GLM-5.2 744B unpruned at 1M context on 4x DGX Spark with NVFP4 compact-KV, 42 tok/s peak.
- [ArgentAIOS/dgx-spark-cluster](https://github.com/ArgentAIOS/dgx-spark-cluster) - 2-node setup with EXO inference, NCCL tuning, NVMe-TCP storage, and 200 Gb/s fabric.
- [bird/GLM-spark](https://github.com/bird/GLM-spark) - GLM-5.2 469B (REAP-pruned from 753B, NVFP4) served across three DGX Spark nodes with vLLM pipeline-parallel, 256K context at ~4.4 tok/s decode.
- [chishiki37/dgx-spark-fabric](https://github.com/chishiki37/dgx-spark-fabric) - Switched 200G MikroTik fabric replacing the direct DAC between two DGX Spark nodes, fixing broken RoCE for 26-33% more decode, with 4x100G and 2x200G measured identical.
- [ciprianveg/gb10-glm-5.2](https://github.com/ciprianveg/gb10-glm-5.2) - GLM-5.2 Int4-Int8Mix on an eight-node GB10 cluster via TP8 and MTP k=4, at 1,329 t/s prefill and 66 t/s peak decode, plus prebuilt GHCR images.
- [CosmicRaisins/glm-5.2-gb10](https://github.com/CosmicRaisins/glm-5.2-gb10) - GLM-5.2 (744B MoE) on a 4-node GB10 cluster, porting the Hopper-only sparse-MLA attention to sm_121 with custom Triton kernels at 256K context.
- [CosmicRaisins/minimax-m3-awq-gb10](https://github.com/CosmicRaisins/minimax-m3-awq-gb10) - MiniMax-M3-AWQ-INT4 vLLM serve recipe for 4x GB10, FP8 KV cache, EAGLE3 spec-decode, and indexer-corruption fix.
- [digchick/dgx-spark-200g-link-fix](https://github.com/digchick/dgx-spark-200g-link-fix) - Troubleshooting playbook for the 200G ConnectX-7 link failing to train between two Sparks (CX7 hotplug power-saving), with the fix and NCCL/RoCE verification.
- [drowzeys/Keys-Setup-Autonomous-Self-Improving-Local-Inference-Stack](https://github.com/drowzeys/Keys-Setup-Autonomous-Self-Improving-Local-Inference-Stack) - Mixture-of-Agents stack for 4x DGX Spark with a DeepSeek-V4-Flash router and a continuous self-LoRA retraining loop.
- [hazyumps/deepseek-v4-flash-gb10](https://github.com/hazyumps/deepseek-v4-flash-gb10) - Recipe and patches to serve DeepSeek-V4-Flash across two GB10 Sparks with vLLM (tensor + expert parallel over RoCE) at 384K context.
- [HeNryous/mimo-v25-dflash-dgx-spark](https://github.com/HeNryous/mimo-v25-dflash-dgx-spark) - MiMo-V2.5 (309B MoE) vLLM recipe on two DGX Spark TP=2 with DFlash speculative decoding at ~54 tok/s single-stream, a 1.67M-token fp8 KV pool at 500K context, and zram/OOM GB10 hardening.
- [idonati/spark-vllm-docker-festr2](https://github.com/idonati/spark-vllm-docker-festr2) - vLLM patches for festr2 MiMo-V2.5 NVFP4/MXFP8 on an 8-node sm_121 cluster, with a fused-QKV loader fix for Q mis-slotted as K/V on 7 of 8 ranks.
- [joeynyc/Hy3-295B-NVFP4-2x-DGX-Spark](https://github.com/joeynyc/Hy3-295B-NVFP4-2x-DGX-Spark) - Hunyuan 3 295B MoE (NVFP4) on two DGX Sparks with vLLM and Ray, 26 tok/s single-stream at 262K context with TurboQuant k8v4 KV cache, plus upstream vLLM fixes (#47792, #47777).
- [josephdrose/nccl-spark-switchless](https://github.com/josephdrose/nccl-spark-switchless) - NCCL v2.30.7 patches for a switchless 4x GB10 RoCE ring with 2-hop store-and-forward relay.
- [karolpalys/glm52-triple-spark-tuning](https://github.com/karolpalys/glm52-triple-spark-tuning) - Tuning log and negative results for GLM-5.2 753B on three DGX Spark nodes, with the measurement methodology and the evidence that killed each rejected change.
- [makiisthenes/dgx-spark-multinode-vllm-ray](https://github.com/makiisthenes/dgx-spark-multinode-vllm-ray) - Dual-DGX Spark vLLM deployment with NVIDIA vLLM 26.04, Ray, and 200 GbE QSFP.
- [MiaAI-Lab/DeepSeek-v4-Flash-DSpark-2x-DGX-Spark](https://github.com/MiaAI-Lab/DeepSeek-v4-Flash-DSpark-2x-DGX-Spark) - Two-node Docker Compose stack for DeepSeek-V4-Flash-0731 on the prebuilt Anemll GX10 vLLM image, with a dated benchmark history and a gibberish, loop, and language-drift triage section.
- [nabe2030/dgx-spark-2node-rpc](https://github.com/nabe2030/dgx-spark-2node-rpc) - 228.5 GB GLM-5.2 GGUF split across two DGX Spark nodes over llama.cpp RPC, with the CX7 link measured as two PCIe Gen5 x4 paths, not one 200G pipe.
- [pfn/spark-vllm-compose](https://github.com/pfn/spark-vllm-compose) - Multi-node Docker Compose configuration for vLLM on DGX Spark.
- [r0b0tlab/DeepSeek-V4-Flash-DSpark-v026-SM121](https://github.com/r0b0tlab/DeepSeek-V4-Flash-DSpark-v026-SM121) - Dual-GB10 DeepSeek-V4-Flash-DSpark on vLLM 0.26, at 80.6 tok/s c1 decode and 402 tok/s aggregate at concurrency 16 against 77.8 and 343 on 0.25.
- [rajsinghtechbot/dgx-spark-vllm-k8s](https://github.com/rajsinghtechbot/dgx-spark-vllm-k8s) - Kubernetes cookbook for DeepSeek-V4-Flash on dual DGX Spark, with Multus/Spiderpool RDMA over RoCEv2, UMA-aware container memory limits, and Prometheus monitoring.
- [RustRunner/DGX-Llama-Cluster](https://github.com/RustRunner/DGX-Llama-Cluster) - Three-node llama.cpp cluster for DGX Spark over ConnectX-7 RDMA, 384 GB pooled unified memory.
- [tomsti/guides](https://github.com/tomsti/guides) - GB10 cluster guide for DGX Spark over ConnectX-7 RoCE, covering NCCL rail pinning, the duplicate-MAC workaround, and MikroTik 400G switching.
- [tonyd2wild/DeepSeek-v4-Flash-DSpark-1M-NVFP4-KV-2x-DGX-Spark](https://github.com/tonyd2wild/DeepSeek-v4-Flash-DSpark-1M-NVFP4-KV-2x-DGX-Spark) - DeepSeek-V4-Flash-DSpark at 1M context on dual DGX Spark, with a patch for the twelve draft tensors vLLM silently drops on the 0731 weights, restoring 78.4 tok/s from half speed.
- [tonyd2wild/GLM-5.2-655K-MTP-4x-DGX-Spark---25-32tok-s](https://github.com/tonyd2wild/GLM-5.2-655K-MTP-4x-DGX-Spark---25-32tok-s) - GLM-5.2 (744B MoE, QuantTrio INT4/INT8) served at 655K-token context across four DGX Sparks via decode-context-parallelism (DCP4), 23 tok/s single-stream with MTP k=3.
- [tonyd2wild/MiMo-V2.5-TP3-NVFP4-KV-3xDGX-Spark](https://github.com/tonyd2wild/MiMo-V2.5-TP3-NVFP4-KV-3xDGX-Spark) - MiMo V2.5 Omni (310B MoE, text/image/video/audio) at tensor-parallel 3 across three DGX Sparks, with 4-bit NVFP4 KV cache for a ~10.6M-token KV pool at 1M context.
- [tonyd2wild/MiniMax-M3-2x-DGX-Spark-36-tok-s](https://github.com/tonyd2wild/MiniMax-M3-2x-DGX-Spark-36-tok-s) - MiniMax-M3 428B unpruned on 2x DGX Spark with W4A16 GPTQ and EAGLE-3 spec-decode, 36 tok/s.
- [tonyd2wild/Minimax-M3-NVFP-3x-DGX-Sparks-TP-3](https://github.com/tonyd2wild/Minimax-M3-NVFP-3x-DGX-Sparks-TP-3) - MiniMax-M3 NVFP4 (428B-A23B) served at tensor-parallel 3 across three DGX Sparks, with head-padding and RoCE fixes.
- [tonyd2wild/nfs-model-weights](https://github.com/tonyd2wild/nfs-model-weights) - NFS recipe for sharing one checkpoint across N DGX Spark nodes, taking a 4-node model library from 6.8 TB to 1.7 TB with no per-node copies.
- [tpurtell/glm-5.2-4x-spark-1x-rtx6k-96gb](https://github.com/tpurtell/glm-5.2-4x-spark-1x-rtx6k-96gb) - Rust attention-FFN disaggregation engine splitting GLM-5.2 across one RTX PRO 6000 coordinator and four DGX Spark expert nodes, at 65 tok/s decode and 1,750 tok/s prefill.
- [urbanspr1nter/dgx-spark-bare-metal](https://github.com/urbanspr1nter/dgx-spark-bare-metal) - Four-node DGX Spark Ray/vLLM cluster (480 GB) for MoE serving, with an sm_121 CUTLASS FP8 patch.
- [vroomfondel/dgxarley](https://github.com/vroomfondel/dgxarley) - Ansible playbooks for a K3s cluster of four DGX Spark nodes and an x86 control plane, running distributed SGLang inference.
- [www-ai-rs/gb10-deepseek-v4-flash](https://github.com/www-ai-rs/gb10-deepseek-v4-flash) - Two-node DGX Spark launcher and benchmark harness for DeepSeek-V4-Flash with GPU rail power sampling and executed correctness tests.
- [ZD-AI-Lab/Triple-GB10](https://github.com/ZD-AI-Lab/Triple-GB10) - Three-node GB10 RoCE ring (QSFP, no switch) for Ray + vLLM pipeline-parallel across 3 Sparks.

## Image & Media Generation

- [AEON-7/comfyui-aeon-spark](https://github.com/AEON-7/comfyui-aeon-spark) - ComfyUI Docker for DGX Spark with SageAttention v3 compiled for sm_121a, CUDA 13, NVFP4, and Flux 2 / LTX 2.3 pre-bundled.
- [bjarkebolding/spark-comfyui](https://github.com/bjarkebolding/spark-comfyui) - ComfyUI lifecycle manager for DGX Spark with a pinned image and a GB10 clock-cap reboot fix.
- [CoconutMacaroon/blender-arm64](https://github.com/CoconutMacaroon/blender-arm64) - Blender build for GB10 aarch64 with CUDA, OptiX, and Vulkan, shipping a prebuilt DGX Spark binary release.
- [dr-vij/Hunyuan3D-2.1-DGX-Spark-Docker](https://github.com/dr-vij/Hunyuan3D-2.1-DGX-Spark-Docker) - Hunyuan3D-2.1 3D generation on DGX Spark via Docker Compose, building custom_rasterizer and DifferentiableRenderer CUDA components on-box.
- [dr-vij/Trellis2-DGX-Spark-Docker](https://github.com/dr-vij/Trellis2-DGX-Spark-Docker) - Trellis2 3D generation on DGX Spark.
- [ecarmen16/SparkyUI](https://github.com/ecarmen16/SparkyUI) - ComfyUI + SageAttention for DGX Spark (aarch64, sm_121).
- [joeynyc/cosmos-locateanything-dgx](https://github.com/joeynyc/cosmos-locateanything-dgx) - Two-stage DGX Spark pipeline: Cosmos 3 video generation, then NVIDIA LocateAnything object grounding.
- [kabilankb/cosmos3-nano-gb10](https://github.com/kabilankb/cosmos3-nano-gb10) - Cosmos3-Nano (16B) video and image generation on GB10 with auto-applied ARM Blackwell patches.
- [luix93/DGX-Spark-ComfyUI](https://github.com/luix93/DGX-Spark-ComfyUI) - ComfyUI Docker Compose for DGX Spark with SageAttention 2 built against sm_121, NVFP4 via comfy_kitchen, and a copy=False patch for the unified-memory double-VRAM bug.
- [mmartial/ComfyUI-Nvidia-Docker](https://github.com/mmartial/ComfyUI-Nvidia-Docker) - Multi-platform ComfyUI Docker (x86_64, Blackwell, DGX Spark) with notes for compiling SageAttention on sm_121a.
- [mvalancy/blender-nvidia-gb10](https://github.com/mvalancy/blender-nvidia-gb10) - Blender 5.0.1 source build for GB10 aarch64 with Cycles CUDA-13 GPU rendering, via 8 sm_121/CUDA-13 patches.
- [phaserblast/ComfyUI-DGXSparkSafetensorsLoader](https://github.com/phaserblast/ComfyUI-DGXSparkSafetensorsLoader) - Zero-copy model loader for ComfyUI on DGX Spark using the fastsafetensors library.
- [Triplany/comfyui-dgx-spark](https://github.com/Triplany/comfyui-dgx-spark) - Updater kit for an existing ComfyUI install on DGX Spark, adding sm_121 SageAttention and an aarch64 cu13 ONNX Runtime wheel.

## Audio & Speech

- [AEON-7/qwen3-asr-server](https://github.com/AEON-7/qwen3-asr-server) - OpenAI /v1/audio/transcriptions server for Qwen3-ASR-0.6B, vLLM-native with sm_120 flash-attn 2, hot-path RTF 16x.
- [AEON-7/qwen3-tts-server](https://github.com/AEON-7/qwen3-tts-server) - OpenAI /v1/audio/speech server for Qwen3-TTS-1.7B-VoiceDesign with sm_120 flash-attn 2, hot-path RTF 1.30x and free-form voice conditioning.
- [briancaffey/nemotron-asr-server](https://github.com/briancaffey/nemotron-asr-server) - Speech-to-text server for DGX Spark with an OpenAI transcriptions API, Nemotron on native NeMo, WebSocket streaming.
- [jxlarrea/homeassistant-voice-recipes](https://github.com/jxlarrea/homeassistant-voice-recipes) - Home Assistant voice stack for DGX Spark with GB10 aarch64 ASR fork and Gemma-4-26B on llama.cpp.
- [kedarpotdar-nv/spark-realtime-chatbot](https://github.com/kedarpotdar-nv/spark-realtime-chatbot) - On-device voice and vision assistant for DGX Spark, ~320 ms voice latency on one GB10 with Qwen3-VL and faster-whisper.
- [Logos-Flux/spark-voice-pipeline](https://github.com/Logos-Flux/spark-voice-pipeline) - Real-time voice assistant on DGX Spark achieving ~766 ms latency to first audio.
- [luka-loehr/qwen3-tts-native](https://github.com/luka-loehr/qwen3-tts-native) - Native Rust and CUDA runtime for Qwen3-TTS-1.7B VoiceDesign on sm_121, streaming 24 kHz PCM with no Python or PyTorch in the inference path.
- [mARTin-B78/dgx-spark-faster-qwen3-tts](https://github.com/mARTin-B78/dgx-spark-faster-qwen3-tts) - Faster-Qwen3-TTS on DGX Spark (GB10) as an OpenAI-compatible TTS API with CUDA-graph acceleration and four voice backends.
- [Mekopa/whisperx-blackwell](https://github.com/Mekopa/whisperx-blackwell) - GPU-accelerated WhisperX on Blackwell (sm_121) for DGX Spark.
- [Pizzaman213/fish-s2pro-gb10](https://github.com/Pizzaman213/fish-s2pro-gb10) - GB10-tuned Fish Audio S2-Pro TTS reaching 31.3 tok/s from 1.2 via bit-exact int8 kernels, speculative decode, and quality-gated NVFP4 weights.
- [WillIsback/whisperx-gb10](https://github.com/WillIsback/whisperx-gb10) - WhisperX transcription and pyannote diarization REST API for GB10 (aarch64, sm_121), with an async job queue, SRT/VTT/TXT export, and prebuilt Docker Hub/GHCR images on NGC PyTorch 25.05.

## Science & HPC

Beyond LLMs, GB10's unified memory and aarch64 stack run scientific compute: protein folding, biomolecular prediction, and RAN simulation.

- [adrian-greenneuron/openfold3-DGX-Spark](https://github.com/adrian-greenneuron/openfold3-DGX-Spark) - OpenFold3 protein-structure prediction on DGX Spark with DeepSpeed sm_121 patches.
- [rcbarke/ai-ran-dgx-spark](https://github.com/rcbarke/ai-ran-dgx-spark) - NVIDIA Aerial and Sionna 5G/6G RAN simulation on DGX Spark over multi-node fabric.
- [sanjyotshenoy/boltz-gb10-spark](https://github.com/sanjyotshenoy/boltz-gb10-spark) - Boltz-2 biomolecular-interaction prediction on DGX Spark with Triton-nightly sm_121 codegen.

## Remote Access & Desktop

- [eelbaz/dgx-spark-headless-sunshine](https://github.com/eelbaz/dgx-spark-headless-sunshine) - Headless remote desktop setup for DGX Spark using Sunshine streaming.
- [seanGSISG/dgx-spark-sunshine-setup](https://github.com/seanGSISG/dgx-spark-sunshine-setup) - Headless 4K remote desktop to DGX Spark over Sunshine.

## Tools & Monitoring

- [agjs/gb10-clock-cap](https://github.com/agjs/gb10-clock-cap) - Clock-cap harness for GB10 inference hosts, measuring 12 C cooler and 36% less GPU power at a 1.0% decode cost and 3.9% prefill cost.
- [amer8/pulsebar](https://github.com/amer8/pulsebar) - Unofficial macOS menu bar monitor that streams GPU and memory telemetry from the DGX Spark dashboard.
- [antheas/spark_hwmon](https://github.com/antheas/spark_hwmon) - Linux hwmon kernel driver exposing GB10 system power telemetry (per-rail power, energy counters, temperatures) and PL1/PL2 power-cap controls via sysfs.
- [ateska/dgx-spark-prometheus](https://github.com/ateska/dgx-spark-prometheus) - Prometheus metrics exporter for DGX Spark clusters.
- [chappa-ai-llc/spark-smi](https://github.com/chappa-ai-llc/spark-smi) - System-monitor TUI for DGX Spark with unified-memory and Grace P/E-core awareness, a cluster fleet view, an MT2910 fabric bandwidth test, and mixed sm_121 plus sm_86 support.
- [CINOAdam/nvml-unified-shim](https://github.com/CINOAdam/nvml-unified-shim) - NVML LD_PRELOAD shim for GB10 unified memory with /proc and CUDA fallback when NVML reports NVML_ERROR_NOT_SUPPORTED.
- [DanTup/dgx_dashboard](https://github.com/DanTup/dgx_dashboard) - Monitoring dashboard for DGX Spark bound to 0.0.0.0, with GB/GiB-correct memory stats, GPU power draw, and Docker container controls.
- [dorangao/dgx-spark-toolkit](https://github.com/dorangao/dgx-spark-toolkit) - Validation scripts for DGX Spark hardware and networking: RoCE checks, NCCL 200 GbE tests, RDMA pods.
- [engineering87/sparkfit](https://github.com/engineering87/sparkfit) - Memory capacity planner for DGX Spark: 128 GB unified-memory split, roofline tok/s estimate, and quantization advisor.
- [GigCoder-ai/dgxtop](https://github.com/GigCoder-ai/dgxtop) - Terminal hardware monitor for DGX Spark with GB10 GPU, CPU, memory, and per-drive I/O speeds.
- [hoesing/spark-gpu-throttle-check](https://github.com/hoesing/spark-gpu-throttle-check) - Throttle test for DGX Spark that loads the GB10 with cuBLAS matmuls to detect sub-850 MHz USB-PD power-delivery throttling.
- [jasonacox/dgx-spark](https://github.com/jasonacox/dgx-spark) - Project hub for DGX Spark with worked GB10 builds: nanochat trained from scratch behind a web chat UI, plus LLM serving and image generation.
- [jeffrymahbuubi/dgx-spark-stress-test](https://github.com/jeffrymahbuubi/dgx-spark-stress-test) - Burn-in suite for GB10 that runs 6-24 hour llama.cpp and stable-diffusion.cpp loads together, reaching ~96% GPU use with 85 GB resident.
- [joeynyc/spark-doctor](https://github.com/joeynyc/spark-doctor) - Read-only diagnostic CLI for DGX Spark: 14 W power cap, unified-memory pressure, thermal risk, CUDA 13 / sm_121 wheel mismatches, Docker runtime, and vLLM/Ollama/SGLang recipe checks.
- [lynx-lee/lynx-ollama](https://github.com/lynx-lee/lynx-ollama) - Ollama manager for DGX Spark with GB10 unified-memory detection and auto-tuned concurrency.
- [mcampa/sparkrun-ui](https://github.com/mcampa/sparkrun-ui) - Web UI for sparkrun on DGX Spark with launch wizard, live log tail, and cluster monitor.
- [mchenetz/sparkd](https://github.com/mchenetz/sparkd) - Localhost dashboard for a DGX Spark fleet, with HF browsing, Claude-generated vLLM recipes, and single-box or Ray-cluster launch.
- [MiaAI-Lab/sparkDash](https://github.com/MiaAI-Lab/sparkDash) - Web dashboard for a DGX Spark fleet with per-server vLLM Prometheus health and Wake-on-LAN power control.
- [parallelArchitect/sparkview](https://github.com/parallelArchitect/sparkview) - Terminal GPU monitor with GB10-aware unified-memory reporting, memory-pressure (PSI) and power-rail readouts, and an anomaly auto-logger.
- [r0b0tlab/hermes-concurrent-agents](https://github.com/r0b0tlab/hermes-concurrent-agents) - Supervised worker pool for Hermes Agent on one GB10, adding pre-claim admission, exact process ownership, restart reconciliation, and bounded review and rework.
- [securitysonar/spark-hashcat](https://github.com/securitysonar/spark-hashcat) - Hashcat REST API service for GB10 aarch64, with an NVRTC CUDA build path that bypasses OpenCL.
- [TheAwaken1/Spark-Studio](https://github.com/TheAwaken1/Spark-Studio) - Launch and tuning dashboard for vLLM, SGLang, llama.cpp, and sparkrun recipes on DGX Spark that hands a broken recipe to Claude Code or Codex to patch and relaunch.
- [vybe/sparky](https://github.com/vybe/sparky) - Vue 3 web UI for DGX Spark with ComfyUI generation, Ollama chat, voice, and container control.
- [wentbackward/nv-monitor](https://github.com/wentbackward/nv-monitor) - Terminal monitor and Prometheus exporter for DGX Spark in one zero-dependency C binary, with HugePages-correct unified memory and Grace big.LITTLE core labels.

## Operating Systems & Containers

- [graham33/nixos-dgx-spark](https://github.com/graham33/nixos-dgx-spark) - Nix and NixOS on DGX Spark with USB images and flake templates.
- [maxspevack/spark-rocky](https://github.com/maxspevack/spark-rocky) - Rocky Linux 10.2 Live-USB for DGX Spark on the CIQ 6.18 kernel and open driver 610.57.04, carrying zero patches of its own and validated at 1.010x benchmark parity.
- [Neural-ICE/ICE-CoreOS](https://github.com/Neural-ICE/ICE-CoreOS) - Immutable bootc OS for DGX Spark on CentOS Stream 10, with the GB10 kernel at 4 KiB pages, a signed Secure Boot chain, and TPM2-unlocked LUKS2.
- [RageLtd/arch-dgx-spark-iso](https://github.com/RageLtd/arch-dgx-spark-iso) - Arch Linux installer ISO builder for DGX Spark, with the linux-dgx-spark kernel and archinstall config.
- [scitrera/cuda-containers](https://github.com/scitrera/cuda-containers) - Prebuilt DGX Spark containers for vLLM, SGLang, llama.cpp, and PyTorch that build NCCL and PyTorch first as a base layer and version by vLLM release rather than tracking git.

## Community & Resource Collections

- [AEON-7/AEON-7](https://github.com/AEON-7/AEON-7) - Index of AEON-7's DGX Spark releases: NVFP4 model packs, prebuilt vLLM images, and a voice-AI stack.
- [jeremyeder/dgx-agentskills](https://github.com/jeremyeder/dgx-agentskills) - Claude Code integration for DGX Spark: local model serving, GPU monitoring, and VM management.
- [odnodn/dgx-spark](https://github.com/odnodn/dgx-spark) - Curated collection of NVIDIA DGX Spark resources and self-hosted AI projects.

## Contributing

Contributions are welcome. Read the [contribution guidelines](contributing.md) before opening a pull request.
