variable region {
  type = string
  description = "Provide region"
}

variable "vpc_dns" {
  type = list(object({
    vpc_cidr = string
    vpc_name = string
    dns_sup  = bool
    dns_host = bool
  }))
}

variable public_cidr {
  type = list(object({
    cidr = string
    subnet_name = string
  }))
  description = "Provide public cidr block"
}

variable instance {
  type        = list(object({
    ec2_type = string
    ec2_name = string
  }))
}

variable ports {
  type        = list(number)
  default     = [22, 80, 3306, 443]
}

variable "rt1" {
  type        = string
}


variable "ig" {
  type        = string
}