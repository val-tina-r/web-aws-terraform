output "website_url" {
    description = "URL del sitio web alojado en S3"
    value       = aws_s3_bucket.website.website_endpoint
}