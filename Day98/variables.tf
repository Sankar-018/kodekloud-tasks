variable "KKE_VPC_CIDR" {
    type        = string
    description = "VPC CIDR"
    default     = "10.0.0.0/16"
}

variable "KKE_SUBNET_CIDR" {
    type        = string
    description = "Subnet CIDR"
    default     = "10.0.1.0/24"
}