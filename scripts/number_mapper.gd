extends Reference
class_name NumberMapper

var _slope: float
var _input_start: float
var _input_end: float
var _output_start: float
var _output_end: float

func _init(input_start: float, input_end:float, output_start: float, output_end: float):
	_input_start = input_start
	_input_end = input_end
	_output_start = output_start
	_output_end = output_end
	_slope = (output_end - output_start) / (input_end - input_start)
	print('slope = ', _slope)

func map(number: float):
	return _output_start + _slope * (number - _input_start)