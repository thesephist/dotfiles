#!/usr/bin/env ink

` I use this script to keep track of deadlines and tasks in plain text locally
on my computer (for school and work). I keep those tasks in separate Markdown
files on disk. This script does one thing: it looks for tasks in those files,
with the following syntax

- [x] MM/DD A completed task that won't show
- [ ] MM/DD Description of Task
- [ ] MM/DD Description of Another Task

from any files passed into the program command line, sorts them by date, and
displays them in an easy to digest format per date. Using this script, I can
keep separate Markdown files for each category of work (each course, club,
commitment) but have a consolidated view of my upcoming tasks and deadlines. `

std := load('vendor/std')
str := load('vendor/str')
sort := load('vendor/quicksort')

log := std.log
f := std.format
slice := std.slice
each := std.each
map := std.map
reduce := std.reduce
filter := std.filter
flatten := std.flatten
readFile := std.readFile

split := str.split
index := str.index
hasPrefix? := str.hasPrefix?
trimPrefix := str.trimPrefix

sortBy := sort.sortBy

Newline := char(10)

Paths := slice(args(), 2, len(args()))
Files := []

` take date e.g. 12/4 and return it as a number, e.g. 1204 `
getDateNumberFromTaskLine := taskLine => (
	restOfLine := trimPrefix(taskLine, '- [ ] ')
	dateStr := slice(restOfLine, 0, index(restOfLine, ' '))

	monthDate := split(dateStr, '/')
	[month := number(monthDate.0), date := number(monthDate.1)] :: {
		[(), _] -> log(f('Invalid month in {{0}}', taskLine))
		[_, ()] -> log(f('Invalid date in {{0}}', taskLine))
		_ -> 100 * month + date
	}
)

` take a date number like 1204 and return it as a '12/4' `
formatDate := date => f('{{0}}/{{1}}', [
	floor(date / 100)
	date % 100
])

` from a text file, extract lines containing tasks marked with - [ ] `
extractTaskLines := text => filter(split(text, Newline), line => hasPrefix?(line, '- [ ] '))

each(Paths, path => readFile(path, file => file :: {
	() -> log(f('Could not read file: {{0}}', [path]))
	_ -> (
		Files.len(Files) := {path: path, text: file}

		len(Files) = len(Paths) :: {
			true -> (
				` extract lines beginning with - [ ] `
				taskLines := flatten(map(Files, file => extractTaskLines(file.text)))

				` sort by date by splitting date and parsing numbers `
				sortedTasks := sortBy(taskLines, getDateNumberFromTaskLine)

				` display, partitioned by date `
				reduce(sortedTasks, (lastDate, taskLine) => (
					curDate := getDateNumberFromTaskLine(taskLine) :: {
						lastDate -> log(taskLine)
						_ -> log(formatDate(curDate) + Newline + taskLine)
					}
					curDate
				), 0)
			)
		}
	)
}))

