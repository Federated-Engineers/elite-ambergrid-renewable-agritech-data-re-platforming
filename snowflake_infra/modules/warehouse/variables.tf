variable "name" {
  type        = string
  description = "Warehouse name"
}

variable "size" {
  type        = string
  description = "Warehouse size: XSMALL, SMALL, MEDIUM, LARGE, etc."
  default     = "XSMALL"
}

variable "initially_suspended" {
  type        = bool
  description = "Whether to create the warehouse in a suspended state"
  default     = true
}

variable "comment" {
  type        = string
  description = "Warehouse description"
  default     = "Managed by Terraform"
}