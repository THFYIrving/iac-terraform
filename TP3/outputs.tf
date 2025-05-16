output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.ec2_web.id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l'instance"
  value       = aws_instance.ec2_web.public_ip
}

output "s3_file_url" {
  description = "URL de l'objet S3 uploadé"
  value       = "https://${var.bucket_name}.s3.amazonaws.com/test-file.txt"
}

output "public_file_url" {
  value = "https://${aws_s3_bucket.demo_bucket.bucket}.s3.amazonaws.com/test-file.txt"
}

output "website_url" {
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
  description = "URL du site web hébergé sur S3"
}
