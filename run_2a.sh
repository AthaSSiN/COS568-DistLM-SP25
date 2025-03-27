#!/bin/bash

export GLUE_DIR=/proj/cos568proj2-PG0/glue_data
export TASK_NAME=RTE
export PATH=$PATH:/users/atharvsp/.local/bin

python3 run_glue.py \
  --model_type bert \
  --model_name_or_path bert-base-cased \
  --task_name $TASK_NAME \
  --do_train \
  --do_eval \
  --data_dir $GLUE_DIR/$TASK_NAME \
  --max_seq_length 128 \
  --per_device_train_batch_size 64 \
  --learning_rate 2e-5 \
  --num_train_epochs 3 \
  --output_dir /tmp/$TASK_NAME/ \
  --overwrite_output_dir \
  --world_size 4 \
  --local_rank $1 &> run_2a_$1.out