#/bin/bash

npm init

npm install -D @types/node @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint eslint-config-prettier eslint-plugin-prettier nodemon prettier rimraf typescript @types/jest jest

wget https://raw.githubusercontent.com/Suppen/dotfiles/master/.prettierrc.json
wget https://raw.githubusercontent.com/Suppen/dotfiles/master/.eslintrc.json
wget https://raw.githubusercontent.com/Suppen/dotfiles/master/.gitignore
wget https://raw.githubusercontent.com/Suppen/dotfiles/master/tsconfig.json

node -e "
const fs = require(\"fs\");
const package = require(\"./package.json\");

package.scripts = {
	\"build\": \"tsc\",
	\"build:dev\": \"tsc --watch --preserveWatchOutput\",
	\"start\": \"NODE_ENV=\\\"production\\\" node dist/app\",
	\"start:dev\": \"NODE_ENV=\\\"development\\\" nodemon dist/app\",
	\"test\": \"jest\",
	\"test:dev\": \"jest --watchAll\",
	\"lint\": \"eslint src/**\",
	\"clean\": \"rimraf dist\"
};

package.jest = {
	\"rootDir\": \"dist/\"
};

fs.writeFileSync(\"./package.json\", JSON.stringify(package, null, 2));
"

mkdir src

touch src/app.ts
touch src/app.test.ts
