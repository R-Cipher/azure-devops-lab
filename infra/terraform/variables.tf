variable "subscription_id" {
  description = "Azure subscription ID to target. This is an identifier, not a credential."
  type        = string
}

variable "location" {
  description = "Azure region for the lab resources."
  type        = string
}

variable "web_app_name" {
  description = "Globally unique name for the Linux Web App; use lowercase letters, numbers, and hyphens."
  type        = string

  validation {
    condition     = length(var.web_app_name) >= 2 && length(var.web_app_name) <= 60 && can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.web_app_name))
    error_message = "The web app name must be 2-60 characters, use lowercase letters, numbers, or hyphens, and start and end with a letter or number."
  }
}

variable "environment" {
  description = "Short environment label used in Azure resource names and tags."
  type        = string
  default     = "lab"
}
