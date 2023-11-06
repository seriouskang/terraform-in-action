variable "test_worker_size" {
  description = "Test Worker Node Size"
  type        = map(string)
  default = {
    "desired" = "2"
    "min"     = "1"
    "max"     = "2"
  }
}