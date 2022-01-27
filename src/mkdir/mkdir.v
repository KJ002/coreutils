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

	for paths in settings.filepaths {
		if !folder_exists(paths) {
			os.mkdir_all(paths) or { eprintln('Directory ‘test’ already exists.') }
		}
	}
}

fn folder_exists(folder string) bool {
	mut path := folder.split('/')
	folder_name := path[path.len - 1]

	path = path[0..path.len - 1] // Omit folder from path

	path_string := path.join('/')

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
