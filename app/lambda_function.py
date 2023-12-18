import boto3
import os
import sys
import uuid
from urllib.parse import unquote_plus
from powerex.email_generator import process_names
            
s3_client = boto3.client('s3')
domain = "powerex.io"

def lambda_handler(event, context):
  for record in event['Records']:
    bucket = record['s3']['bucket']['name']
    key = unquote_plus(record['s3']['object']['key'])
    tmpkey = key.replace('/', '')
    download_path = '/tmp/{}{}'.format(uuid.uuid4(), tmpkey)
    upload_path = '/tmp/emails_from_{}'.format(tmpkey)
    s3_client.download_file(bucket, key, download_path)
    process_names(download_path, upload_path, domain)
    s3_client.upload_file(upload_path, '{}-emails'.format(bucket), 'emails_from_{}'.format(key))
    print(event)
    return { 
        'event' : event
    }
