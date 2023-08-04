variable "aws_access_key" {

}

variable "aws_secret_key" {

}

variable "env" {
    
}

variable "aws_glue_iam_arn" {
    default = "arn:aws:iam::481156467834:role/my-glue-s3-role"
}

variable "scripts_bucket" {
    default = "aws-glue-assets-481156467834-ap-south-1"
}