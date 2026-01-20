variable "name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  type        = string
}

variable "charset" {
  description = "The character set of the database"
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "The collation of the database"
  type        = string
  default     = "en_US.UTF8"
}
