# This is a KCL document

# attribute
title = "KCL Example"

# dictionary
owner = {
  name = "The KCL Authors"
  data = "2020-01-02T03:04:05"
}

database = {
  enabled = True
  ports = [8000, 8001, 8002]
  data = [["delta", "phi"], [3.14]]
  temp_targets = {cpu = 79.5, case = 72.0}
}

# list with dictionaries
servers = [
  {ip = "10.0.0.1", role = "frontend"}
  {ip = "10.0.0.2", role = "backend"}
]
