resource "local_file" "my_file" {
  filename        = "demo-automated.txt"
  content         = "Assalam o Alaikum"
  file_permission = 0664
}

