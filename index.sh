#!/bin/sh
set -e

if [ -z "$REPO_URL" ]; then
  echo "REPO_URL not set" >&2
  exit 1
fi

if [ -d /src/.git ]; then
  echo "pulling..."
  git -C /src pull --ff-only
else
  echo "cloning..."
  git clone --depth 1 "$REPO_URL" /src
fi

cd /src
echo "extracting..."
graphify extract . --code-only --force

echo "clustering..."
graphify cluster-only .

echo "publishing..."
mkdir -p /data
cp -r graphify-out/. /data/

echo "indexed $(date -u) — $(python -c 'import json;g=json.load(open("/data/graph.json"));print(len(g.get("nodes",[])),"nodes")' 2>/dev/null || echo ok)"
