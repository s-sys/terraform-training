variables {
  docker_image_name = "ubuntu:jammy"
  keep_locally      = false
}

run "validate_ubuntu_version" {
  command = plan
  
  assert {
    condition     = docker_image.ubuntu.name == var.docker_image_name
    error_message = "Ubuntu image not valid."
  }
}  

run "validate_docker_cache" {
  command = plan
  
  assert {
    condition     = docker_image.ubuntu.keep_locally == var.keep_locally
    error_message = "Docker image should not be cached locally."
  }
}
