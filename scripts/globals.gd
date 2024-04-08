extends Node

var score = 0
var camera = null
var boss_active = false
var door_count = 3

signal broken(pos)
signal punishment
signal success
