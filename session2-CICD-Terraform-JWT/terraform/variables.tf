
variable "akeyless_access_id" {
  description = "Akeyless Access ID"
  type        = string
  sensitive   = false
}

variable "akeyless_access_key" {
  description = "Akeyless Access Key"
  type        = string
  sensitive   = true
}

variable "akeyless_gateway_url" {
  description = "Akeyless gateway URL with suffix /api/v2"
  type        = string
  sensitive   = true
}

variable "akeyless_root_path" {
  description = "Akeyless root path, e.g. /devops"
  type        = string
  sensitive   = true
}


