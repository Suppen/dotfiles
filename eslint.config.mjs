// @ts-check

// npm install -D globals @eslint/js typescript-eslint eslint-plugin-prettier ./prettier.config.mjs eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-promise eslint-plugin-import

import globals from "globals";
import eslint from "@eslint/js";
import tseslint from "typescript-eslint";
import prettierPlugin from "eslint-plugin-prettier";
import prettierConfig from "./prettier.config.mjs";
import reactPlugin from "eslint-plugin-react";
import reactHooksPlugin from "eslint-plugin-react-hooks";
import jsxA11yPlugin from "eslint-plugin-jsx-a11y";
import pluginPromise from "eslint-plugin-promise";
import importPlugin from "eslint-plugin-import";

export default tseslint.config(
	eslint.configs.recommended,
	tseslint.configs.recommendedTypeChecked,
	pluginPromise.configs["flat/recommended"],
	importPlugin.flatConfigs.recommended,
	{
		languageOptions: {
			ecmaVersion: "latest",
			sourceType: "module",
			parserOptions: {
				projectService: true,
				tsconfigRootDir: import.meta.dirname,
			},
			globals: globals.browser
		},
	},
	{
		files: ["**/*.{jsx,tsx}"],
		plugins: {
			"react": reactPlugin,
			"react-hooks": reactHooksPlugin,
			"jsx-a11y": jsxA11yPlugin
		},
		rules: {
			"react/button-has-type": ["warn"],
			"react/jsx-no-useless-fragment": ["warn"],

			"react-hooks/rules-of-hooks": "error",
			"react-hooks/exhaustive-deps": "warn",

			"jsx-a11y/alt-text": "warn",
		},
		settings: {
			react: {
				version: "detect"
			}
		}
	},
	{
		files: ["**/*.{js,mjs,cjs,ts,jsx,tsx}"],
		plugins: {
			prettier: prettierPlugin
		},
		rules: {
			"prettier/prettier": ["error", prettierConfig],

			"import/order": ["warn", {
				groups: ["builtin", "external", "internal", "parent", "sibling", "index", "object", "type"],
				alphabetize: { order: "asc", caseInsensitive: true },
				"newlines-between": "always"
			}],
			"import/no-unresolved": "error",
			"import/newline-after-import": "warn",
			"import/no-duplicates": "warn",

			"eqeqeq": ["error", "always"],
			"no-eval": ["error"],
			"no-implied-eval": ["error"],
			"no-return-await": ["warn"],
			"class-methods-use-this": ["warn"],
			"no-console": ["error", { allow: ["warn", "error"] }],
			"@typescript-eslint/explicit-function-return-type": ["warn"],
			"@typescript-eslint/explicit-module-boundary-types": ["error"],
			"@typescript-eslint/consistent-type-imports": ["error"],
			"@typescript-eslint/switch-exhaustiveness-check": ["warn"],
		}
	}
);
