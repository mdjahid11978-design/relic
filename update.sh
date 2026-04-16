#!/bin/bash
# Relic Update Script
# Updates protocol and template files only. Your personal data (SOUL.md, USER.md, MEMORY.md, SESSIONS/, ARCHIVE/) is NEVER touched.
# Usage: cd ~/relic && bash update.sh

set -e

REPO="https://github.com/LucioLiu/relic.git"
BRANCH="main"
TMPDIR=$(mktemp -d)

echo "🔄 Checking for Relic updates..."

# Clone latest to temp dir
git clone --depth 1 -b "$BRANCH" "$REPO" "$TMPDIR/relic" 2>/dev/null

# Get version info
NEW_VERSION=$(cat "$TMPDIR/relic/brain/.relic-version" 2>/dev/null || echo "unknown")
CUR_VERSION=$(cat brain/.relic-version 2>/dev/null || echo "unknown")

if [ "$NEW_VERSION" = "$CUR_VERSION" ]; then
    echo "✅ Already up to date (v$CUR_VERSION)"
    rm -rf "$TMPDIR"
    exit 0
fi

echo "📦 Updating: v$CUR_VERSION → v$NEW_VERSION"

# Update protocol files (safe — these contain no user data)
cp "$TMPDIR/relic/brain/PROTOCOL.md" brain/PROTOCOL.md
cp "$TMPDIR/relic/brain/PROTOCOL.en.md" brain/PROTOCOL.en.md
cp "$TMPDIR/relic/brain/SOUL.template.md" brain/SOUL.template.md
cp "$TMPDIR/relic/brain/USER.template.md" brain/USER.template.md
cp "$TMPDIR/relic/brain/MEMORY.template.md" brain/MEMORY.template.md
cp "$TMPDIR/relic/brain/.relic-version" brain/.relic-version

# Update skill files
mkdir -p skill 2>/dev/null || true
cp "$TMPDIR/relic/skill/SKILL.md" skill/SKILL.md 2>/dev/null || true
cp "$TMPDIR/relic/SKILL.md" SKILL.md 2>/dev/null || true

# Update docs
mkdir -p docs 2>/dev/null || true
cp "$TMPDIR/relic/docs/PLAN.md" docs/PLAN.md 2>/dev/null || true
cp "$TMPDIR/relic/docs/TROUBLESHOOTING.md" docs/TROUBLESHOOTING.md 2>/dev/null || true

# Update READMEs
cp "$TMPDIR/relic/README.md" README.md
cp "$TMPDIR/relic/README.zh-CN.md" README.zh-CN.md
cp "$TMPDIR/relic/LICENSE" LICENSE
cp "$TMPDIR/relic/.gitignore" .gitignore

# Update integration guides
mkdir -p examples/integrations 2>/dev/null || true
cp "$TMPDIR/relic/examples/integrations/"* examples/integrations/ 2>/dev/null || true

# NEVER touch these files:
# - brain/SOUL.md
# - brain/USER.md  
# - brain/MEMORY.md
# - brain/SESSIONS/
# - brain/ARCHIVE/
# - brain/INBOX/
# - brain/SKILLS/
# - brain/PROJECTS/

# Cleanup
rm -rf "$TMPDIR"

echo "✅ Updated to v$NEW_VERSION"
echo "📋 Your SOUL.md, USER.md, MEMORY.md, SESSIONS/, and ARCHIVE/ are untouched."
