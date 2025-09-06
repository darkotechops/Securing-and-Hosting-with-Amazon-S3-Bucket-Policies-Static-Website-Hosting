provider "aws" {
  region = "us-east-1"  # Change this to your desired region
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "website-bucket"  # Replace with your desired bucket name

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Enable public access to the bucket
  acl = "public-read"
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  content = "<html><body><h1>Error: Page Not Found</h1></body></html>"
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  content = "<html><body><h1>Welcome to the Static Website</h1></body></html>"
}

resource "aws_s3_bucket_object" "text_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "text.html"
  content = "<html><body><h1>Placeholder Page</h1></body></html>"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode({
    Version = "2012-10-17"
    Id = "StaticWebPolicy"
    Statement = [
      {
        Sid = "S3GetObjectAllow"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"
      }
    ]
  })
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}

/*
Explanation of the Terraform Code:
aws_s3_bucket: This resource creates the S3 bucket and enables static website hosting. The index.html and error.html are set as the index and error documents, respectively.

aws_s3_object (error_html): This creates the error.html object in the bucket. This HTML file serves as the error page for the website.

aws_s3_object (index_html): This creates the index.html object in the bucket. This HTML file serves as the homepage or the index page for the website.

aws_s3_object (text_html): This creates the placeholder text.html object, which is required for renaming to error.html based on the instructions provided in the original setup.

aws_s3_bucket_policy: This resource creates a bucket policy that allows public access to the objects in the bucket. It allows anyone to perform s3:GetObject on any object within the specified S3 bucket.

Output: The bucket_website_endpoint output will give you the URL endpoint of the static website once the bucket is successfully created and configured.
*/

/*
Steps to Run This Terraform Code:
Make sure you have the AWS CLI set up with your AWS credentials and that Terraform is installed on your system.
Save the above code into a file, e.g., main.tf.
Run the following commands:
terraform init to initialize the working directory.
terraform apply to create the resources in AWS.
This Terraform code will automatically configure your S3 bucket for static website hosting,
create the required error page, and set up the appropriate bucket policy.
You can verify the static website hosting by checking the endpoint provided by the output after the apply is complete.
*/
