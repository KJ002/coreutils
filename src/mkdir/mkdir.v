module main

import common
import os

const (
	app_name        = 'mkdir'
	app_description = 'create new empty directories'
)

struct Settings {
	parent_dir bool
	mode       string
	verbose    bool
	filepaths  []string
}

fn main() {
	settings := args()

	for path in settings.filepaths {
		if !folder_exists(path) {
			os.mkdir_all(path) or { eprintln('Directory ‘test’ already exists.') }

			if settings.verbose {
				println('Created directory $path')
			}
		}
	}
}

fn folder_exists(folder string) bool {
	mut path := folder.split('/')
	folder_name := path[path.len - 1]

	path = path[0..path.len - 1] // Omit folder from path

	mut path_string := path.join('/')

	if path_string == '' {
		path_string = '.'
	}

	contents := os.ls(path_string) or {
		eprintln('Directory ‘$path_string does not exist.’')
		return true
	}

	return folder_name in contents
}

fn args() Settings {
	mut fp := common.flag_parser(os.args)
	fp.application(app_name)
	fp.description(app_description)

	mode := fp.string('mode', `m`, '', 'set file mode')
	parent_dir := fp.bool('parents', `p`, false, 'create parent directories')
	verbose := fp.bool('verbose', `v`, false, 'print to stdout a message for each created directory')
	filepaths := fp.finalize() or { return Settings{} }

	return Settings{parent_dir, mode, verbose, filepaths}
}
