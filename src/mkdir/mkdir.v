module main

import os

const (
	app_name        = 'mkdir'
	app_description = 'create new empty directories'
)

fn main() {
	os.mkdir('./test') or { eprintln('Directory ‘test’ already exists.') }
}
