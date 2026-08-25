job "api" {
  datacenters = ["dc1"]

  group "api" {
    count = 2
    network {
      port "http" {}
    }
    
    service {
      provider = "nomad"
      name = "api"
      port = "http"
      tags = ["http"]
    }

    task "api" {
      driver = "java"
      artifact {
        source      = "git::https://github.com/panchal-ravi/nomad-java.git"
        destination = "local/repo"
      }
      config {
        jar_path = "local/repo/api/api.jar"
        args = ["--server.port=${NOMAD_PORT_http}"]
      }
    }
  }
}