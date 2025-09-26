provider "aws" {
  region     = "ap-south-2"
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "myunique-microdegree-prathima-123"
    tags = {
      Name = "myunique-microdegree-prathima-123"
      Environment = "dev"
    }
}

