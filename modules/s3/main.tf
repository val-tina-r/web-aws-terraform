#creacion bucket s3
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
  tags  = var.common_tags
}

#configuracion del bucket para hosting web
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

}

#desactivar el bloqueo de acceso público para permitir el hosting web
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#configuracion de bucket policy para permitir el acceso público al hosting web
resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.website.id
    
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Sid = "PublicReadGetObject"
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.website.arn}/*"
        }
        ]
    })
}

#subir el archivo index.html al bucket
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  tags = var.common_tags

  depends_on = [aws_s3_bucket_policy.bucket_policy]
}



