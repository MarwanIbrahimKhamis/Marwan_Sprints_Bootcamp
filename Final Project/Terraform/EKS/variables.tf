variable "cluster_name" {
  description = "The name of the EKS cluster to create."
}

variable "subnet_ids" {
  description = "A list of subnet IDs to use for the EKS cluster and worker nodes."
  type        = list(string)
}

variable "instance_type" {
  description = "The EC2 instance type to use for the worker nodes."
}