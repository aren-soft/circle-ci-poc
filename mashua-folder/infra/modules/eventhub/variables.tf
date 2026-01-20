variable "name" {
  description = "The name for the event hub."
  type        = string
}

variable "namespace_id" {
  description = "The ID of the Event Hub namespace."
  type        = string
}

variable "partition_count" {
  description = "The number of partitions for the event hub."
  type        = number
  default     = 2
}

variable "message_retention" {
  description = "The message retention period in days."
  type        = number
  default     = 1
}

variable "status" {
  description = "The status of the event hub."
  type        = string
  default     = "Active"
}
