module.exports = {
    extends: ['@commitlint/config-conventional'],
    rules: {
        // Puedes personalizar reglas aquí si lo deseas en el futuro
        'type-enum': [
            2,
            'always',
            [
                'build',
                'chore',
                'ci',
                'docs',
                'feat',
                'fix',
                'perf',
                'refactor',
                'revert',
                'style',
                'test'
            ]
        ]
    }
};