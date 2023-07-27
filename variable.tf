variable "project_id" {
  description = "The ID of the project in which resources will be created."

}

variable "region" {
  description = "The region in which resources will be created."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone in which resources will be created."
  default     = "us-central1-a"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  default     = "10.0.0.0/16"
}

variable "machine_type" {
  description = "The machine type for the instance."
  default     = "f1-micro"
}

variable "image" {
  description = "The image from which the instance will be created."
  default     = "debian-cloud/debian-11"
}

variable "instance_count" {
  description = "The number of instances to create."
  default     = 2
}

variable "instance_name_prefix" {
  description = "The prefix for the instance names."
  default     = "demo-instance"
}