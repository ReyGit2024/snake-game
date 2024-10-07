#variables "nombre-del-recurso" {
#
#
#
#
#
#type = string       
#}

# Definición de variables sensibles en variables.tf
variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}
variable "resource_group_name" {
  type = string
  
}