#!/bin/bash
# ClawHub 发布脚本
# 从干净的 GitHub 源头自动组装 ClawHub 包并发布
# 用法: bash publish-clawhub.sh [版本号]
# 示例: bash publish-clawhub.sh 1.2.4

set -e

VERSION="${1:-patch}"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
STAGING="/tmp/relic-clawhub-staging"

echo "📦 Assembling ClawHub package..."

rm -rf "$STAGING"
mkdir -p "$STAGING/docs"

cp "$REPO_DIR/SKILL.md" "$STAGING/SKILL.md"
cp "$REPO_DIR/SKILL.zh-CN.md" "$STAGING/SKILL.zh-CN.md"
cp "$REPO_DIR/AGENT.md" "$STAGING/AGENT.md"
cp "$REPO_DIR/AGENT.zh-CN.md" "$STAGING/AGENT.zh-CN.md"
cp "$REPO_DIR/docs/upload-soul.md" "$STAGING/docs/"
cp "$REPO_DIR/docs/upload-soul.zh-CN.md" "$STAGING/docs/"
cp "$REPO_DIR/docs/load-soul.md" "$STAGING/docs/"
cp "$REPO_DIR/docs/load-soul.zh-CN.md" "$STAGING/docs/"
cp "$REPO_DIR/docs/resonate-soul.md" "$STAGING/docs/"
cp "$REPO_DIR/docs/resonate-soul.zh-CN.md" "$STAGING/docs/"

echo "📋 Files in staging:"
find "$STAGING" -type f | sort

echo ""
echo "🚀 Publishing to ClawHub..."
clawhub publish "$STAGING" --slug relic-soul-chip --version "$VERSION"

echo ""
echo "🧹 Cleaning up staging..."
rm -rf "$STAGING"

echo "✅ Done!"
