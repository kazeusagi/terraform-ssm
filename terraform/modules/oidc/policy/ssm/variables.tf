variable "name" {
  description = "ポリシーの名前"
  type        = string
}

variable "allowed_instance_arns" {
  description = "許可するインスタンスのARNのリスト"
  type        = list(string)
}
