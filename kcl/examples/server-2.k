# default configuration
schema DatabaseConfig:
  enable: bool = True
  ports: [int] = [8000, 8001, 8002]
  data: [[str|float]] = [["delta", "phi"], [3.14]]
  temp_targets: {str: float} = {cpu = 79.5, case = 72.0}

schema ServerConfig:
  # required when no default value
  ip: str
  # enumeration
  role: "frontend" | "backend"

# unique name
databaseNew = DatabaseConfig {
  ports = [2020, 2021]
}

serversNew = [
  ServerConfig {ip = "10.0.0.1", role = "frontend"}
  ServerConfig {ip = "10.0.0.2", role = "backend"}
]
