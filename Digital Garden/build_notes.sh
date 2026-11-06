#!/bin/bash
# Build Quartz site AND fix all links to include .html

cd "/Users/hamsini/Chaos/hamsini-digital-garden/Digital Garden"
npm run prebuild 2>/dev/null
npx quartz build

# Fix all note links to explicitly include .html
for f in "/Users/hamsini/Chaos/hamsini-digital-garden/Digital Garden/public"/*.html; do
  sed -i '' 's|href="./note-\([0-9]*\)"|href="./note\1.html"|g' "$f"
  sed -i '' 's|href="./note\([0-9]*\)"|href="./note\1.html"|g' "$f"
  sed -i '' 's|href="./About_these_notes"|href="./About_these_notes.html"|g' "$f"
done

echo "Build complete - all links fixed"
