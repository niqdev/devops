# variables with underscore prefix are non-exported and mutable
# i.e. it will not appear in the output YAML, and it can be assigned multiple times
_priority = option("priority")
_cpu = 256
_env = "dev"

if _priority == 1:
    _cpu = 256
elif _priority == 2:
    _cpu = 512
elif _priority == 3:
    _cpu = 1024
else:
    _cpu = 2048

_priorityCpuMap = {
    "1" = 256
    "2" = 512
    "3" = 1024
}

_name = "nginx"

cpu = _cpu
# using a dict to simplify logic and the default value is 2048
cpuFromMap = _priorityCpuMap[str(_priority)] or 2048
memory = _cpu * 2

_command = [_name] # a list
_command = _command + ["-f", "file"]  # Append items into command using + operator to contact two lists
command = [c.lower() for c in _command]  # Take each element in the list to lowercase

_labels = {
    run = "my-{}".format(_name)
    if _env:
        env = _env  # Append a dict key-value pair when the _env is not None/Undefined or empty using if expressions
}
labels = _labels # a dict

image = "{}:1.14.2".format(_name) # string format
service = "my-service"
