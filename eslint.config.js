/*
npm install -D eslint eslint-config-prettier eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-prettier \
eslint-plugin-promise eslint-plugin-react globals prettier typescript-eslint @eslint/js
*/

import globals from "globals";
import pluginJs from "@eslint/js";
import tseslint from "typescript-eslint";
import pluginReact from "eslint-plugin-react";
// import pluginReactHooks from "eslint-plugin-react-hooks";
import pluginImport from "eslint-plugin-import";
import pluginPromise from "eslint-plugin-promise";
import configPrettier from "eslint-config-prettier";
import pluginPrettierRecommended from "eslint-plugin-prettier/recommended";
import jsxA11y from "eslint-plugin-jsx-a11y";

export default [
	{
		files: ["**/*.{js,mjs,cjs,ts,jsx,tsx}"]
	},
	{
		languageOptions: {
			ecmaVersion: "latest",
			sourceType: "module",
			globals: globals.node
		}
	},
	pluginJs.configs.recommended,
	...tseslint.configs.recommended,
	pluginImport.flatConfigs.recommended,
	pluginPromise.configs["flat/recommended"],

	// React
	pluginReact.configs.flat.recommended,
	jsxA11y.flatConfigs.recommended,
	// pluginReactHooks.configs.recommended,

	// Prettier
	configPrettier,
	pluginPrettierRecommended,
	{
		rules: {
			// ESLint
			"no-var": "error",
			"prefer-const": "error",
			eqeqeq: "error",
			"class-methods-use-this": "error",
			"no-eval": "error",

			// Handled by prettier
			// "no-multi-spaces": "error",
			// "semi": ["error", "always"],

			// React
			"react/react-in-jsx-scope": "off",
			"react/jsx-uses-react": "off"
		}
	}
];
