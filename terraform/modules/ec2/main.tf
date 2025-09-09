# SSH Key: enable_ssh が true の場合のみ作成
resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "main" {
  count      = var.enable_ssh ? 1 : 0
  key_name   = "${var.name}-key"
  public_key = tls_private_key.main.public_key_openssh
}




# インスタンスプロファイル用のロール
resource "aws_iam_role" "main" {
  name               = "${var.name}-ec2_Role"
  assume_role_policy = data.aws_iam_policy_document.ec2.json
}
# SSM 許可ポリシー: enable_ssm が true の場合のみアタッチ
resource "aws_iam_role_policy_attachment" "main" {
  count      = var.enable_ssm ? 1 : 0
  role       = aws_iam_role.main.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# インスタンスプロファイル
resource "aws_iam_instance_profile" "main" {
  name = "${var.name}-ec2_InstanceProfile"
  role = aws_iam_role.main.name
}



# EC2
resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.enable_ssh ? aws_key_pair.main[0].key_name : null # enable_ssh が true の場合のみ設定
  iam_instance_profile   = aws_iam_instance_profile.main.name

  tags = {
    Name = "${var.name}-ec2"
  }
}



# SSH Keyをローカルに保存: enable_ssh が true の場合のみ保存
resource "local_file" "ssh_key" {
  count           = var.enable_ssh ? 1 : 0
  filename        = "${path.cwd}/.ssh/${var.name}-key.pem"
  content         = tls_private_key.main.private_key_pem
  file_permission = "0400"
  depends_on      = [aws_key_pair.main]
}
# IPアドレスをローカルに保存: enable_ssh が true の場合のみ保存
resource "local_file" "ip_address" {
  count      = var.enable_ssh ? 1 : 0
  filename   = "${path.cwd}/.ssh/${var.name}-ip.txt"
  content    = aws_instance.main.public_ip
  depends_on = [aws_instance.main]
}
# インスタンスIDをローカルに保存: enable_ssm が true の場合のみ保存
resource "local_file" "instance_id" {
  count      = var.enable_ssm ? 1 : 0
  filename   = "${path.cwd}/.ssh/${var.name}-instance-id.txt"
  content    = aws_instance.main.id
  depends_on = [aws_instance.main]
}
