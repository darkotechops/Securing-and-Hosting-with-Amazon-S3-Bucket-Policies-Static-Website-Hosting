# Steps to Finish

### 1. Review Bucket Policy to Secure an S3 Bucket
### 2. Enable Static Website Hosting on S3

---

## Instructions

### 1. Navigate to S3 in the AWS Management Console

### 2. Click on the Bucket Name under the "General Purpose Buckets" tab

### 3. Set Up Error Page
1. On the bucket page, copy the bucket name from the top (e.g., `website-bucket-000111`).
2. In the "Objects" section, locate and select `text.html`.
3. Click on the "Actions" dropdown and choose **Rename Object**.
4. On the **Rename Object** page, set the new object name to `error.html` and click **Save Changes**.
   - *Note*: This file will act as your error page and will be displayed whenever something goes wrong.

### 4. Review Bucket Permissions
1. On the bucket page, in the success alert, review the message and click on **Permissions**.
2. On the **Permissions** page, turn off the option **Block all public access**. This is necessary for enabling static web hosting through your S3 bucket.

### 5. Configure Bucket Policy
1. On the same **Permissions** page, scroll down to the **Bucket Policy** section.
2. Review or update the policy to match the following:

   ```json
   {
     "Version": "2012-10-17",
     "Id": "StaticWebPolicy",
     "Statement": [
       {
         "Sid": "S3GetObjectAllow",
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::website-bucket-000as1f01/*"
       }
     ]
   }
- *Note*: This policy allows public access to the S3 bucket.
- Effect: This policy allows access.
- Principal: Defines who has access; in this case, * represents anyone.
- Action: Defines the actions allowed. Here, users can only retrieve data with GetObject.
- Resource: Specifies that this policy applies only to the specified bucket.
- Security Note: Generally, to safeguard against unintentional data exposure, we recommend using strict S3 bucket permissions in production environments.
    
5. Scroll up to the top of page and click on  "Properites" then navigate to section "Static website hosting" and click on "EDIT"

6. On "Edit static website hosting" page setup should look like :
- Static website hosting = Enable
- Hosting type = Host a static website
- Index document = Type > index.html
-Error document - optional = Type > error.html
7.Scroll down and click on "Save changes"

### 6. Verify Static Website Hosting
1. Scroll down to the Static website hosting section.
- Review to ensure that the hosting type is set to Bucket hosting.
- Under Bucket endpoint, click the Copy icon and open the link in a new tab.
2. Verify that the webpage launches without any issues.

