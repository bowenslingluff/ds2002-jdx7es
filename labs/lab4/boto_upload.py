import boto3
import requests
import argparse
import os

def download_file(url, filename):
	response = requests.get(url, stream=True)
	if response.status_code == 200:
		with open(filename, 'wb') as f:
			f.write(response.content)

def upload_to_s3(filename, bucket, expires_in=None):
	s3 = boto3.client('s3', region_name="us-east-1")
	resp = s3.put_object(
		Body = filename,
    	Bucket = bucket,
    	Key = filename
	)
	url = s3.generate_presigned_url(
		'get_object',
		Params={'Bucket': bucket, 'Key': filename},
		ExpiresIn=expires_in
	)
	return url


def main():
	parser = argparse.ArgumentParser(description="Download, upload to S3, and generate a presigned URL.")
	parser.add_argument('file_url', type=str, help='URL of the file to download')
	parser.add_argument('bucket_name', type=str, help='S3 bucket name')
	parser.add_argument('expires_in', type=int, help='Presigned URL expiration time in seconds')

	args = parser.parse_args()

	filename = os.path.basename(args.file_url)
	download_file(args.file_url, filename)
	url = upload_to_s3(filename, args.bucket_name)
	print(url)

main()