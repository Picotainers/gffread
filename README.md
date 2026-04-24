# gffread

Source-built container for `gffread`, a utility for parsing, filtering, converting, and extracting transcript features from GFF/GTF annotations.

## Quick Usage

```bash
docker run --rm docker.io/picotainers/gffread gffread --help
```

## Usage

```bash
# Show help
docker run --rm docker.io/picotainers/gffread gffread --help

# Run with local files mounted into /data
docker run --rm -v "$(pwd):/data" docker.io/picotainers/gffread \
  gffread /data/input.gtf -T -o /data/output.gff3
```

## Building

```bash
docker build -t picotainers/gffread .
```

## Primary Use Case

Use `gffread` to normalize and convert annotation files (GTF/GFF), extract transcript structures, and prepare annotations for downstream RNA-seq and genome annotation workflows.
