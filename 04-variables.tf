##########################################
############### General ##################
##########################################
variable "project_name" {
  type = string
}
variable "env" {
  type = string
}
variable "tags" {
  type        = map(any)
  description = "Map of Default Tags"
}
variable "region" {
  type = string
}
