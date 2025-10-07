#!/usr/bin/env bash
#
# For licensing see accompanying LICENSE_MODEL file.
# Copyright (C) 2025 Apple Inc. All Rights Reserved.
#

set -euo pipefail

download() {
    local url="$1"
    local destination_dir="$2"
    local filename

    filename=$(basename "$url")

    if command -v wget >/dev/null 2>&1; then
        wget -q --show-progress "$url" -P "$destination_dir"
    elif command -v curl >/dev/null 2>&1; then
        curl -L --progress-bar "$url" -o "$destination_dir/$filename"
    else
        echo "Error: neither wget nor curl is available. Please install one of them and retry." >&2
        exit 1
    fi
}

mkdir -p checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_0.5b_stage2.zip" checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_0.5b_stage3.zip" checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_1.5b_stage2.zip" checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_1.5b_stage3.zip" checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_7b_stage2.zip" checkpoints
download "https://ml-site.cdn-apple.com/datasets/fastvlm/llava-fastvithd_7b_stage3.zip" checkpoints

# Extract models
cd checkpoints
unzip -qq llava-fastvithd_0.5b_stage2.zip
unzip -qq llava-fastvithd_0.5b_stage3.zip
unzip -qq llava-fastvithd_1.5b_stage2.zip
unzip -qq llava-fastvithd_1.5b_stage3.zip
unzip -qq llava-fastvithd_7b_stage2.zip
unzip -qq llava-fastvithd_7b_stage3.zip

# Clean up
rm llava-fastvithd_0.5b_stage2.zip
rm llava-fastvithd_0.5b_stage3.zip
rm llava-fastvithd_1.5b_stage2.zip
rm llava-fastvithd_1.5b_stage3.zip
rm llava-fastvithd_7b_stage2.zip
rm llava-fastvithd_7b_stage3.zip
cd -
