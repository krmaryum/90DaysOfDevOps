
provider "aws" {
	region = "us-east-2"
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-buck-task-3"
}

/*
(dynamic name)

You can also make it unique automatically:
resource "aws_s3_bucket" "my_bucket" {
  bucket = "buck-mkk-${random_id.bucket_id.hex}"
 }

resource "random_id" "bucket_id" {
  byte_length = 4
}
*/

