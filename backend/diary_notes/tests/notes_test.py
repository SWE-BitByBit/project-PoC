import json
import boto3
import pytest
from moto import mock_dynamodb2, mock_s3
from uuid import uuid4
from datetime import datetime, timezone

from diary_notes.AwsDynamoS3Api import AwsDynamoS3Api

TABLE_NAME = "notes_table"
BUCKET_NAME = "notes-bucket"
TEST_USER_ID = str(uuid4())
TEST_NOTE_ID = str(uuid4())
TEST_FILE_NAME = "image.png"

@pytest.fixture
def setup_moto_env():
    # Mock DynamoDB
    with mock_dynamodb2():
        dynamodb = boto3.resource("dynamodb", region_name="us-east-1")
        table = dynamodb.create_table(
            TableName=TABLE_NAME,
            KeySchema=[
                {"AttributeName": "user_id", "KeyType": "HASH"},
                {"AttributeName": "note_id", "KeyType": "RANGE"}
            ],
            AttributeDefinitions=[
                {"AttributeName": "user_id", "AttributeType": "S"},
                {"AttributeName": "note_id", "AttributeType": "S"}
            ],
            BillingMode="PAY_PER_REQUEST"
        )

        table.put_item(
            Item={
                "user_id": TEST_USER_ID,
                "note_id": TEST_NOTE_ID,
                "created_at": datetime.now(timezone.utc).isoformat(),
                "message": "Test note",
                "s3Key": f"{TEST_USER_ID}/{TEST_NOTE_ID}/{TEST_FILE_NAME}",
                "bucketName": BUCKET_NAME
            }
        )

        # Mock S3
        with mock_s3():
            s3 = boto3.client("s3", region_name="us-east-1")
            s3.create_bucket(Bucket=BUCKET_NAME)

            yield table, s3

def test_list_notes(setup_moto_env):
    table, s3 = setup_moto_env
    api = AwsDynamoS3Api(table, s3)

    event = {
        "requestContext": {
            "authorizer": {
                "jwt": {
                    "claims": {
                        "sub": TEST_USER_ID
                    }
                }
            }
        }
    }

    response = api.list_notes(event)
    assert response["statusCode"] == 200

    body = json.loads(response["body"])
    assert isinstance(body, list)
    assert len(body) == 1
    note = body[0]
    assert note["note_id"] == TEST_NOTE_ID
    assert note["message"] == "Test note"
    assert "presigned_url" in note 