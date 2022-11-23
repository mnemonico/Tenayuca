#output "address" {
#  value       = aws_s3_bucket.example.address
#  description = "Connect to the database at this endpoint"
#}
#
#output "port" {
#  value       = aws_db_instance.example.port
#  description = "The port the database is listening on"
#}
output "terraform" {
  value       = aws_s3_bucket.terraform.bucket
  description = "Terraform Bucket where we store state file"
}

output "kms-s3" {
  value       = aws_kms_alias.s3.target_key_id
  description = "Terraform Bucket KMS Key for S3"
}