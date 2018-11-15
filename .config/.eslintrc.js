module.exports = {
    "compilerOptions": {
        "experimentalDecorators": true
    },
    "parserOptions": {
        "ecmaVersion": 7,
        "ecmaFeatures": {
            "experimentalObjectRestSpread": true,
            "jsx": true
        },
        "sourceType": "module"
    },
    "env": {
        "browser": true,
        "es6": true,
        "node": true
    },
    "plugins": [
        "standard",
        "promise"
    ],
    "globals": {
        "document": true,
        "navigator": true,
        "window": true
    },
    "parser": "babel-eslint",
    "rules": {
        "indent": [
            2,
            2
        ],
        "accessor-pairs": 2,
        "arrow-parens": [
            1,
            "as-needed"
        ],
        "arrow-spacing": [
            2,
            {
                "before": true,
                "after": true
            }
        ],
        "block-spacing": [
            2,
            "always"
        ],
        "brace-style": [
            2,
            "1tbs",
            {
                "allowSingleLine": true
            }
        ],
        "comma-dangle": [
            2,
            "never"
        ],
        "comma-spacing": [
            2,
            {
                "before": false,
                "after": true
            }
        ],
        "comma-style": [
            2,
            "last"
        ],
        "constructor-super": 2,
        "curly": [
            2,
            "multi-line"
        ],
        "dot-location": [
            2,
            "property"
        ],
        "eqeqeq": [
            1,
            "allow-null"
        ],
        "generator-star-spacing": [
            2,
            {
                "before": true,
                "after": true
            }
        ],
        "handle-callback-err": [
            2,
            "^(err|error)$"
        ],
        "keyword-spacing": [
            2,
            {
                "before": true,
                "after": true,
                "overrides": {}
            }
        ],
        "key-spacing": [
            2,
            {
                "beforeColon": false,
                "afterColon": true
            }
        ],
        "new-cap": [
            2,
            {
                "newIsCap": true,
                "capIsNew": false
            }
        ],
        "new-parens": 2,
        "no-array-constructor": 2,
        "no-caller": 2,
        "no-class-assign": 2,
        "no-cond-assign": 2,
        "no-const-assign": 2,
        "no-control-regex": 2,
        "no-debugger": 2,
        "no-delete-var": 2,
        "no-dupe-args": 2,
        "no-dupe-class-members": 2,
        "no-dupe-keys": 2,
        "no-duplicate-case": 2,
        "no-empty-character-class": 2,
        "no-eval": 2,
        "no-ex-assign": 2,
        "no-extend-native": 2,
        "no-extra-bind": 2,
        "no-extra-boolean-cast": 2,
        "no-extra-parens": [
            2,
            "functions"
        ],
        "no-fallthrough": 2,
        "no-floating-decimal": 2,
        "no-func-assign": 2,
        "no-implied-eval": 2,
        "no-inner-declarations": [
            2,
            "functions"
        ],
        "no-invalid-regexp": 2,
        "no-irregular-whitespace": 2,
        "no-iterator": 2,
        "no-label-var": 2,
        "no-labels": [
            2,
            {
                "allowLoop": false,
                "allowSwitch": false
            }
        ],
        "no-lone-blocks": 2,
        "no-mixed-spaces-and-tabs": 1,
        "no-multi-spaces": 2,
        "no-multi-str": 2,
        "no-multiple-empty-lines": [
            2,
            {
                "max": 2
            }
        ],
        "no-native-reassign": 2,
        "no-negated-in-lhs": 2,
        "no-new": 2,
        "no-new-func": 2,
        "no-new-object": 2,
        "no-new-require": 2,
        "no-new-wrappers": 2,
        "no-obj-calls": 2,
        "no-octal": 2,
        "no-octal-escape": 2,
        "no-proto": 2,
        "no-redeclare": 2,
        "no-regex-spaces": 2,
        "no-return-assign": 1,
        "no-self-compare": 2,
        "no-sequences": 2,
        "no-shadow-restricted-names": 2,
        "no-spaced-func": 2,
        "no-sparse-arrays": 2,
        "no-this-before-super": 2,
        "no-throw-literal": 2,
        "no-trailing-spaces": 0,
        "no-undef": 2,
        "no-undef-init": 2,
        "no-unexpected-multiline": 2,
        "no-unneeded-ternary": [
            2,
            {
                "defaultAssignment": false
            }
        ],
        "no-unreachable": 2,
        "no-unused-vars": [
            1,
            {
                "vars": "all",
                "args": "none"
            }
        ],
        "no-useless-call": 2,
        "no-with": 2,
        "one-var": [
            2,
            {
                "initialized": "never"
            }
        ],
        "operator-linebreak": [
            2,
            "after",
            {
                "overrides": {
                    "?": "before",
                    ":": "before"
                }
            }
        ],
        "quotes": [
            1,
            "single",
            "avoid-escape"
        ],
        "radix": 2,
        "semi": [
            0,
            "always"
        ],
        "semi-spacing": [
            1,
            {
                "before": false,
                "after": true
            }
        ],
        "space-before-blocks": [
            2,
            "always"
        ],
        "space-before-function-paren": [
            1,
            "never"
        ],
        "space-in-parens": [
            2,
            "never"
        ],
        "space-infix-ops": 2,
        "space-unary-ops": [
            2,
            {
                "words": true,
                "nonwords": false
            }
        ],
        "spaced-comment": [
            2,
            "always",
            {
                "markers": [
                    "global",
                    "globals",
                    "eslint",
                    "eslint-disable",
                    "*package",
                    "!",
                    ","
                ]
            }
        ],
        "use-isnan": 2,
        "valid-typeof": 2,
        "wrap-iife": [
            2,
            "any"
        ],
        "yoda": [
            2,
            "never"
        ],
        "standard/object-curly-even-spacing": [
            2,
            "either"
        ],
        "standard/array-bracket-even-spacing": [
            2,
            "either"
        ],
        "standard/computed-property-even-spacing": [
            2,
            "even"
        ]
    }
}
