##
# Module to build the Azure DevOps "seed" configuration
##

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

resource "aws_s3_bucket" "terraform_state" {
  bucket = "mundose22"
  
  tags = {
    Name = "terraform_state_bucket"
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "El nombre del bucket S3 donde se almacena el estado de Terraform."
}

