resource "aws_s3_bucket" "terraform_state" {
  bucket = "mundose22"
  
  tags = {
    Name = "terraform_state_bucket"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraformstatelock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraformstatelock"
  }
}

terraform {
  backend "s3"{
    bucket                 = "mundose22"
    region                 = "us-east-1"
    key                    = "backend.tfstate"
    dynamodb_table         = "terraformstatelock"
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "El nombre del bucket S3 donde se almacena el estado de Terraform."
}


