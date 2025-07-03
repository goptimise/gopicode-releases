#!/bin/bash
set -e

echo "🏗️  Starting local GopiCode Server build..."

# Navigate to the gopicode-server directory
cd ../gopicode-server

DISABLE_V8_COMPILE_CACHE=1 npm run gulp vscode-reh-web-linux-x64-min && \
version=$(node -p "require('./package.json').version") && \
name="gopicode-server-v${version}-linux-x64" && \
mkdir ${name} && cp -r ../vscode-reh-web-linux-x64/. ${name}/ && \
tar -czf ${name}.tar.gz ${name} && \
cp ${name}.tar.gz ../gopicode-releases/ && \
cd ../gopicode-releases && \
gh release create gopicode-server-v${version} --title "GopiCode Server v${version}" --notes "Linux Code Server build v${version}" ${name}.tar.gz