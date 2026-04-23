# gffread
Small source-built container for `gffread`.

## Quick Usage

```bash
# Pull the image
docker pull docker.io/picotainers/gffread:latest

# Run the tool
docker run --rm docker.io/picotainers/gffread:latest gffread --help
```

## Run with mounted local data

```bash
docker run --rm -v "$(pwd):/data" docker.io/picotainers/gffread:latest gffread --help
```
