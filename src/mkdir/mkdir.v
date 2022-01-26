module main

import os

const (
	app_name        = 'mkdir'
	app_description = 'create new empty directories'
)

fn main() {
	println(folder_exists('./test/test2/test3'))
	os.mkdir('./test') or { eprintln('Directory ‘test’ already exists.') }
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
