#!/bin/bash

npm create vite@latest .

npm install
npm install -D @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint eslint-config-prettier eslint-plugin-prettier prettier @types/jest jest ts-jest

wget https://raw.githubusercontent.com/Suppen/dotfiles/master/.eslintrc.js
wget https://raw.githubusercontent.com/Suppen/dotfiles/master/.prettierrc.json

node -e "
const fs = require(\"fs\");
const package = require(\"./package.json\");

package.scripts = {
	...package.scripts,
	\"test\": \"jest\",
	\"test:dev\": \"jest --watchAll\",
	\"lint\": \"eslint src/**\"
};

package.jest = {
	\"preset\": \"ts-jest\",
	\"testEnvironment\": \"node\",
	\"rootDir\": \"src/\"
};

fs.writeFileSync(\"./package.json\", JSON.stringify(package, null, 2));
"
