import os
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError
import json
from datetime import datetime, timezone
from uuid import uuid4

class AwsDynamoS3Api:

    def __init__(self, dynamoTable, s3Client):
        self.db_table = dynamoTable
        self.s3_client = s3Client

    def generate_presigned_url(self, client_method, params, expires_in = 3600):
        """
            Create pre-signed action link for uploading file (image in this case) to AWS Bucket.
        """
        try:
            return self.s3_client.generate_presigned_url(
                ClientMethod=client_method,
                Params=params,
                ExpiresIn=expires_in
            )
        except ClientError:
            print("Couldn't get a presigned URL for client method GET /notes.")
            raise

    def response(self, status, body):
        return {
            "statusCode": status,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(body)
        }

    def add_note(self, event):
        body = json.loads(event["body"])
        user_id = event["requestContext"]["authorizer"]["jwt"]["claims"]["sub"]
        message = body.get('message')
        file_name = body.get('fileName')

        if not message and not file_name:
            return self.response(
                400,
                {"msg": "A note must contain text, an image, or both"}
            )

        note_id = str(uuid4())
        item = {
            "user_id": user_id,
            "note_id": note_id,
            "created_at": datetime.now(timezone.utc).isoformat()
        }
        
        if message:
            item["message"] = message
        
        upload_url = None
        
        if file_name:
            s3_key = f"{user_id}/{note_id}/{file_name}"
            item.update({
                "s3Key": s3_key,
                "bucketName": os.environ["BUCKET_NAME"],
            })
            upload_url = self.generate_presigned_url(
                "put_object",
                {
                    "Bucket": os.environ["BUCKET_NAME"],
                    "Key": s3_key,
                },
                300
            )
        self.db_table.put_item(Item=item)
        response_body = {"note_id": note_id}
        if upload_url:
            response_body["presigned_url"] = upload_url
        return self.response(201, response_body)

    def list_notes(self, event):
        user_id = event["requestContext"]["authorizer"]["jwt"]["claims"]["sub"]
        result = self.db_table.query(
            KeyConditionExpression=Key("user_email").eq(user_id)
        )

        notes = []

        for item in result.get("Items", []):
            note = {
                "id": item["note_id"],
                "message": item.get("message", ""),
                "created_at": item["created_at"]
            }
            if "s3Key" in item:
                note["presigned_url"] = self.generate_presigned_url(
                    "get_object",
                    {
                        "Bucket": os.environ["BUCKET_NAME"],
                        "Key": item["s3Key"],
                    },
                    300)
            notes.append(note)

        return self.response(200, notes)

    