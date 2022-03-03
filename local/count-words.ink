#!/usr/bin/env ink

` count-words.ink
	This script attempts to estimate an answer to the question, "How many words
	has Linus written online?" `

` We assume this script runs in my home dir, so that we can assume a vendored
import path for the Ink library sources. `
std := load('./src/ink/samples/std')
str := load('./src/ink/samples/str')

log := std.log
f := std.format
cat := std.cat
trim := str.trim

` List of content repositories I'm counting. This so far covers:
	- thesephist.com
	- linus.coffee
	- dotink.co
	- guides.thesephist.com
	- oaklang.org
	- zerotocode.org `
ContentRepos := [
	'www'
	'coffee'
	'dotink'
	'guides'
	'oak/www'
	'zerotocode'
]

withRepoCount := (repo, cb) => exec(
	'sh'
	['-c', f('cat ~/src/{{ 0 }}/content/*.md ~/src/{{ 0 }}/content/**/*.md | wc -w', [repo])]
	''
	evt => evt.type :: {
		'data' -> (
			stdout := trim(trim(evt.data, char(10)), ' ')
			(number(stdout) :: {
				() -> log(f('exec error: could not convert result ({{ 0 }}) to number', [stdout]))
				_ -> (
					count := number(stdout)
					log(f('Count from {{0}}: {{1}}', [repo, count]))
					cb(count)
				)
			})
		)
		_ -> log('exec error: ' + string(evt))
	}
)

(sub := (i, count) => ContentRepos.(i) :: {
	() -> log(f('Total word count in {{0}}:{{2}}{{1}}'
		[cat(ContentRepos, ', '), count, char(10) + char(9)]))
	_ -> withRepoCount(ContentRepos.(i), repoCount => (
		sub(i + 1, count + repoCount)
	))
})(0, 0)

