#!/bin/bash

# Verify that the script is the only file in the directory
SCRIPT_DIR=$(dirname "$0")
FILE_COUNT=$(ls -1A | wc -l)
if [[ "$FILE_COUNT" -gt 1 ]]; then
	echo "The script must be the only file in the directory. Quitting"
	exit 1
fi

# Remove this script. Vite will complain if it is in the directory
rm "$0"

# Create a vite project with typescript and react
npm create vite@latest . -- --template react-swc-ts

# Install the default dependencies
npm install

# Install some more dev dependencies, for a better development experience
npm install -D \
	@testing-library/react \
	@testing-library/user-event \
	@testing-library/jest-dom \
	@typescript-eslint/eslint-plugin \
	@typescript-eslint/parser \
	@vitest/coverage-v8 \
	eslint \
	eslint-config-prettier \
	eslint-plugin-prettier \
	jsdom \
	prettier \
	sass \
	vitest \

# XXX I would like the following files to simply be downloaded from git, but that requiers authentication. Adding tokens
# to the script will just be cumbersome, so the files are inlined here instead

# Setup ESLint
echo "module.exports = {
	root: true,
	env: {
		es6: true,
		jest: true,
		node: true
	},
	extends: [
		\"eslint:recommended\",
		\"plugin:@typescript-eslint/recommended\",
		\"plugin:@typescript-eslint/recommended-requiring-type-checking\",
		\"prettier\",
		\"plugin:prettier/recommended\"
	],
	parser: \"@typescript-eslint/parser\",
	parserOptions: {
		\"ecmaVersion\": 2020,
		\"sourceType\": \"module\",
		\"project\": [
			\"./tsconfig.json\"
		]
	},
	plugins: [
		\"@typescript-eslint\",
		\"prettier\",
		\"react-hooks\"
	],
	rules: {
		\"no-var\": \"error\",
		\"prefer-const\": \"warn\",
		\"eqeqeq\": \"error\",
		\"class-methods-use-this\": \"warn\",
		\"prettier/prettier\": \"error\",
		\"no-eval\": \"error\",
		\"no-multi-spaces\": \"error\",
		\"react-hooks/rules-of-hooks\": \"error\",
		\"react-hooks/exhaustive-deps\": \"warn\"
	}
}" > .eslintrc.cjs

# Setup prettier
echo "{
	\"printWidth\": 120,
	\"tabWidth\": 4,
	\"useTabs\": false,
	\"trailingComma\": \"none\",
	\"bracketSpacing\": true,
	\"arrowParens\": \"avoid\",
	\"endOfLine\": \"auto\"
}" > .prettierrc

# Setup the test environment
echo "import { cleanup } from \"@testing-library/react\";
import { expect, afterEach } from \"vitest\";
import matchers from \"@testing-library/jest-dom/matchers\";

// Add DOM matchers to \`expect\`
expect.extend(matchers);

// Clear the DOM after each test
afterEach(() => {
    cleanup();
});
" > src/test-setup.ts

echo "/// <reference types=\"vitest\" />
/// <reference types=\"vite/client\" />

import { defineConfig } from \"vite\";
import react from \"@vitejs/plugin-react-swc\";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    environment: \"jsdom\",
	setupFiles: [\"src/test-setup.ts\"]
  }
})" > vite.config.ts

# Update package.json with some new scripts
node -e "
const fs = require(\"fs\");
const package = require(\"./package.json\");

package.scripts = {
	...package.scripts,
	\"test\": \"vitest --mode test\",
	\"coverage\": \"vitest --coverage --mode test\",
	\"lint\": \"eslint src --ext js,jsx,ts,tsx --report-unused-disable-directives --max-warnings 0\",
};

fs.writeFileSync(\"./package.json\", JSON.stringify(package, null, 2));
"

# Add stuff to .gitignore
echo "" >> .gitignore
echo "# Other" >> .gitignore
echo "coverage" >> .gitignore

# Fix lint errors. Vite sets up with different styles than we have defined
npx eslint --fix src
