 terraform {
   
  backend "s3" {
    bucket         = "week10-pm-terraform"
    key            = "LockID"
    region         = "us-east-1"
    dynamodb_table = "state-log"
    encrypt        = true
  }

 }