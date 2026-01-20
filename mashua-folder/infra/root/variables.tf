variable "billing_account_name" {
  description = "The Billing Account Name."
  type        = string
  sensitive   = true
}

variable "billing_profile_name" {
  description = "The Billing Profile Name."
  type        = string
  sensitive   = true
}

variable "invoice_section_name" {
  description = "The Invoice Section Name."
  type        = string
  sensitive   = true
}

variable "subscription_names" {
  description = "List of names for the Subscriptions to be created under the defined Billing Scope."
  type        = list(string)
}

variable "users_role_assignments" {
  description = <<EOT
    Map's key: string. Corresponds to an Azure Built-in Role to assign to a set of Entra ID users over the new created subscription. More info on Buil-in Roles: https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
    Map's value: list of string. Corresponds to the Entra ID 'user principal name' of each users you want to assign the defined role on the new created subscription.
    example:
        users_role_assignments = {
            "Contributor": ["user.01@domain.com", "user.02@domain.com"],
            "Owner": ["user.01@domain.com"],
            "Role Based Access Control Administrator": ["user.01@domain.com", "user.04@domain.com", "user.10@domain.com"]
        }
  EOT
  type        = map(list(string))
  default     = {}
}
