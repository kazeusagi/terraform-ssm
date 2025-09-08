variable "name" {
  description = "名前"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "インスタンスタイプ"
  type        = string
}

variable "subnet_id" {
  description = "サブネットID"
  type        = string
}

variable "security_group_id" {
  description = "セキュリティグループID"
  type        = string
}

variable "enable_ssh" {
  description = "SSHを有効にするか"
  type        = bool
}

variable "enable_ssm" {
  description = "SSMを有効にするか"
  type        = bool
}
