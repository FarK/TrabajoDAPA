#!/bin/python

from os import system
import sys

test_benches = {}

test_benches["pc_tb.v"] = ["code_mem/pc.v"]
test_benches["ir_tb.v"] = ["code_mem/ir.v"]
test_benches["cs2014_tb.v"] =	[
					"cs2014.v",
					"alu/*.v",
					"control/unidad_control.v",
					"code_mem/ir.v",
					"code_mem/pc.v",
					"data_mem/*.v",
					"registers/*.v",
					"u_datos.v",
					"perisph/perisph_select.v"
				]

sim = ""
skip = 1
if len(sys.argv) >= 2 and sys.argv[1] == "--sim":
	sim = "sim"
	skip = 2

if len(sys.argv) == 1 or (len(sys.argv) == 2 and sim == "sim"):
	for tb, deps in test_benches.iteritems():
		system('make TB="' + tb + '" TB_DEPS="' + ' '.join(deps) + '" ' + sim)

if len(sys.argv) >= 2:
	for arg in sys.argv[skip:]:	# Nos saltamos los primeros
		if arg in test_benches:
			system('make TB="' + arg + '" TB_DEPS="' + ' '.join(test_benches[arg]) + '" ' + sim)
			print('make TB="' + arg + '" TB_DEPS="' + ' '.join(test_benches[arg]) + '" ' + sim)
		else:
			print('ERROR: Test bench "' + arg + '" not found')
else:
	print("Usage:\n\t" + sys.argv[0] + " [--sim] + <test_bench1> <test_bench2> ...")
