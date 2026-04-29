variable "bucket_name" {
  description = "Nombre del bucket"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas"
  type        = map(string)
}