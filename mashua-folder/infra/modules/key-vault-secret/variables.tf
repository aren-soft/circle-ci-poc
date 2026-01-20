variable "key_vault_id" {
  description = "The ID of the Azure Key Vault where the secret will be stored."
  type        = string
}

variable "secret_name" {
  description = "The name of the secret to store in Azure Key Vault."
  type        = string
}

variable "secret_value" {
  description = "The value of the secret to store in Azure Key Vault."
  type        = string
  sensitive   = true
}
