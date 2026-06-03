# compress

CLI tool to compress videos while preserving resolution and framerate. Uses H.265/HEVC encoding via FFmpeg with smart size estimation before processing.

## Features

- **Preserves quality** — Maintains original resolution and FPS
- **Size estimation** — Shows estimated output size before encoding, with confirmation prompt
- **Progress bar** — Real-time progress with ETA
- **4 speed presets** — `ultrafast`, `fast`, `medium`, `slow`
- **Max file size** — Optional cap with automatic two-pass encoding
- **Batch processing** — Compress multiple files at once
- **Apple compatible** — HVC1 tag + faststart for QuickTime/iOS

## Install

```bash
# macOS / Linux (requires ffmpeg)
curl -fsSL https://raw.githubusercontent.com/Mbeckero/compress/main/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/Mbeckero/compress.git
chmod +x compress/compress
cp compress/compress ~/.local/bin/
```

### Requirements

- **ffmpeg** — `brew install ffmpeg` (macOS) or `sudo apt install ffmpeg` (Linux)
- **python3** — For metadata parsing and calculations
- **bash** — 4.0+

## Usage

```bash
# Basic (medium preset, default)
compress video.mov

# Choose speed preset
compress video.mov --ultrafast    # Fastest, larger file
compress video.mov --fast         # Quick, good balance
compress video.mov --medium       # Default, optimal balance
compress video.mov --slow         # Slowest, smallest file

# Set max file size (MB)
compress video.mov --max 500

# Skip confirmation prompt
compress video.mov --fast -y

# Custom CRF (18=near lossless, 28=aggressive)
compress video.mov --crf 21

# Batch processing
compress *.mov --fast
compress *.mp4 --slow --max 400

# Drag & drop from Finder
compress [drag file here] --fast
```

## How it works

```
$ compress video.mov --fast

──────────────────────────────────────────────────
📹 Input: video.mov
   1920x1080 · 29.97fps · hevc · 8.7 Mbps
   525.5 MB · 8m 17s

⚙️  Config: preset=fast · crf=23
📦 Output: video_compressed.mp4
──────────────────────────────────────────────────

🔍 Estimating final size (30s sample)...

📊 Estimation:
   Current size:   525.5 MB
   Estimated size: ~190 MB
   Estimated save: ~335 MB (-63.8%)

Continue? [S/n]: s

  █████████████████░░░░░░░░░░░░░  56.3%  ETA: 2m 45s

✓ Compression successful
──────────────────────────────────────────────────
  Before:    525.5 MB  (8.7 Mbps)
  After:     186.3 MB  (3.0 Mbps)
  Saved:     339 MB (-64.5%)
  Time:      6m 00s
  Accuracy:  97.8% vs estimation
  Output:    /path/to/video_compressed.mp4
──────────────────────────────────────────────────
```

## Presets comparison

| Preset | Speed | Compression | Best for |
|--------|-------|-------------|----------|
| `ultrafast` | ⚡⚡⚡⚡ | Low | Quick previews |
| `fast` | ⚡⚡⚡ | Good | Daily use |
| `medium` | ⚡⚡ | Better | Default balance |
| `slow` | ⚡ | Best | Final delivery |

Quality is visually identical across all presets — what changes is how efficiently bits are distributed. Slower presets = smaller file at same quality.

## Notes

- Output is saved in the same directory as input with `_compressed.mp4` suffix
- Won't overwrite existing files — adds `_1`, `_2`, etc.
- Works best with raw/high-bitrate source files
- Re-compressing already compressed videos yields diminishing returns

## License

MIT
