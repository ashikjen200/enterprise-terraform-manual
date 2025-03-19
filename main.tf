resource "aws_instance" "public_instance" {
 ami           = var.ami
 instance_type = var.instance_type

 tags = {
   Name = var.name_tag,
 }
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-ashik-12345"
  acl    = "public-read"  # This grants public read access to the bucket

  tags = {
    Name = "Public Bucket"
  }
}

resource "aws_s3_bucket_object" "public_object" {
  bucket = aws_s3_bucket.public_bucket.bucket
  key    = "public_file.txt"
  content = "This is a publicly accessible file."
}

resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.bucket

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
      }
    ]
  })
}
