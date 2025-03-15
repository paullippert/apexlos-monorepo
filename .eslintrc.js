module.exports = {
  root: true,
  // This tells ESLint to load the config from the package
  extends: ["eslint:recommended", "prettier"],
  settings: {
    next: {
      rootDir: ["apps/*/"],
    },
  },
  rules: {
    "no-unused-vars": [
      "error",
      {
        argsIgnorePattern: "^_",
        varsIgnorePattern: "^_",
      },
    ],
  },
  env: {
    node: true,
  },
  overrides: [
    {
      files: ["**/*.ts", "**/*.tsx"],
      parser: "@typescript-eslint/parser",
      plugins: ["@typescript-eslint"],
      extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended", "prettier"],
    },
  ],
};
