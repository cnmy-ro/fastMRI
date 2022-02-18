#!/bin/bash
#
#SBATCH --job-name=fastmri_sc_unet_infer
#SBATCH --output=fastmri_sc_unet_infer.%j.log

# Compute and memory
#SBATCH --partition=LKEBgpu
#SBATCH --gres=gpu:V100:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16G

# Time
#SBATCH --time=05:00:00

# Load/add required modules
module purge
module load library/cuda/11.3/gcc.8.3.1

# Debugging info
hostname
echo "Cuda devices: $CUDA_VISIBLE_DEVICES"
nvidia-smi
echo

# Change current working dir
echo Changing working dir ...
cd /exports/lkeb-hpc/csrao/git-personal/fastMRI/fastmri_examples/unet/
echo Current working dir: $(pwd)
echo

# Run python script
python_interpreter=/exports/lkeb-hpc/csrao/miniconda3/envs/mri/bin/python3
$python_interpreter run_pretrained_unet_inference.py \
                    --challenge unet_knee_sc                    \
                    --data_path $FASTMRI_DATA_ROOT_LAURENS/knee/singlecoil_test_v2 \
                    --output_path /exports/lkeb-hpc/csrao/results/fastmri_sc_unet_trial
                      