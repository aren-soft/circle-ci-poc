variable "billing_scope_id" {
  description = "The ID of the scope of billing account"
  type        = string
}

variable "subscription_name" {
  description = "The name to assign to the new subscription"
  type        = string
}

variable "workload" {
  description = "The workload type of the Subscription. Possible values are Production (default) and DevTest. Changing this forces a new Subscription to be created."
  type        = string
  default     = "Production"
}
