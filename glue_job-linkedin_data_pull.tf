resource "aws_s3_object" "linkedin_data_ingestion" {
  bucket = "${var.scripts_bucket}"
  key    = "scripts/ingestion/linkedin_data_pull.py"
  source = "../sam_data_ingest/linkedin/data_ingestion.py"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../sam_data_ingest/linkedin/data_ingestion.py")
}

resource "aws_glue_job" "linkedin_data_ingest" {
  name         = "${var.env}-linkedin_data_pull"
  role_arn     = "${var.aws_glue_iam_arn}"
  glue_version = "4.0"
  worker_type  = "G.1X"
  number_of_workers = 2

  command {
    python_version  = "3"
    script_location = "s3://${var.scripts_bucket}/scripts/ingestion/linkedin_data_pull.py"
  }

  default_arguments = {
    # ... potentially other arguments ...
    "--RELEASE_TIMESTAMP" = "2023-08-04"
    "--INPUT_PATH" = "s3://sam-linkedin-data/data/"
    "--OUTPUT_PATH"     = "s3://my-source-bucket-sammedtech/linkedin/"
  }
}