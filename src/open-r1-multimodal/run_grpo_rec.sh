cd src/open-r1-multimodal

export DEBUG_MODE="true"
# export CUDA_VISIBLE_DEVICES=4,5,6,7

RUN_NAME="Qwen2-VL-2B-GRPO-REC"
export LOG_PATH="./debug_log_$RUN_NAME.txt"

torchrun --nproc_per_node="8" \
    --nnodes="1" \
    --node_rank="0" \
    --master_addr="127.0.0.1" \
    --master_port="12345" \
    src/open_r1/grpo_rec.py \
    --output_dir /data9/shz/project/r1v/R1-V/output/$RUN_NAME \
    --model_name_or_path /data9/shz/ckpt/Qwen2.5-VL-3B-Instruct \
    --dataset_name ./data_script/rec.yaml \
    --image_root /data9/shz/dataset/coco \
    --max_prompt_length 1024 \
    --num_generations 2 \
    --per_device_train_batch_size 1 \
    --gradient_accumulation_steps 2 \
    --logging_steps 1 \
    --bf16 \
    --torch_dtype bfloat16 \
    --data_seed 42 \
    --report_to wandb \
    --gradient_checkpointing false \
    --attn_implementation flash_attention_2 \
    --max_pixels 401408 \
    --num_train_epochs 2 \
    --run_name $RUN_NAME \
    --save_steps 100 \
    --save_only_model true