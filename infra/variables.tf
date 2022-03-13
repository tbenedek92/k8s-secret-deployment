variable "token" {
  description = "Token to be used for authentication with linode"
  type        = string
  default     = ""
  sensitive   = true
}

variable "label" {
  description = "Kubernetes cluster's unique label"
  type        = string
  default     = ""
}

variable "region" {
  description = "Kubernetes cluster's region"
  type        = string
  default     = "eu-west"
}

variable "pool_type" {
  description = "Node type to be provisioned"
  type        = string
  default     = "g6-standard-1"
}

variable "pool_count" {
  description = "Number of nodes to be provisioned with the k8s-cluster"
  type        = number
  default     = 1
}