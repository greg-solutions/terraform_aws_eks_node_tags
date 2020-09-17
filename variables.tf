variable "namespace" {
  type = string
  description = "(Optional) Namespace name"
  default = "node-tags-attach"
}
variable "name" {
  type = string
  description = "App Name"
  default = "add-more-tags"
}
variable "create_namespace" {
  type = bool
  description = "(Optional) If true module will create namespace for app"
  default = true
}
variable "region" {
  type = string
  description = "(Required) AWS Region where EC2 deployed"
}
variable "additional_tags" {
  type = string
  description = "String of tags for EC2 instance (example 'Key=key1,Value=value1 Key=foo,Value=bar Key=Name,Value=MyEC2')"
}