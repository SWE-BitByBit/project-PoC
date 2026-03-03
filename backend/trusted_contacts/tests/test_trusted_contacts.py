import boto3
import json
import pytest
from moto import mock_aws
from uuid import uuid4

from trusted_contacts.AwsDynamoApi import AwsDynamoApi

TABLE_NAME = "Prova-table"
TEST_CONTACT_ID = str(uuid4())
TEST_USER_ID = str(uuid4())

@pytest.fixture
def setUp_mock_dynamo():
    with mock_aws():
        dynamodb = boto3.resource("dynamodb", region_name="us-east-1")

        dynamodb.create_table(
            TableName=TABLE_NAME,
            KeySchema=[
                {"AttributeName": "user_id", "KeyType": "HASH"},
                {"AttributeName": "contact_id", "KeyType": "RANGE"}
            ],
            AttributeDefinitions=[
                {"AttributeName": "user_id", "AttributeType": "S"},
                {"AttributeName": "contact_id", "AttributeType": "S"}
            ],
            BillingMode="PAY_PER_REQUEST",
        )

        table = dynamodb.Table(TABLE_NAME)
        table.put_item(
            Item={
                "user_id": TEST_USER_ID,
                "contact_id": TEST_CONTACT_ID,
                "name": "Luigi",
                "email": "luigi@email.com"
            }
        )

        yield table

def test_add_contact(setUp_mock_dynamo):
    event = {
        "body": json.dumps({
            "name": "Mario Rossi",
            "email": "mario@email.com"
        }),
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

    db = AwsDynamoApi(setUp_mock_dynamo)
    response = db.add_contact(event)
    assert response["statusCode"] == 201

def test_delete_contact(setUp_mock_dynamo):
    delete_event = {
        "pathParameters": {"contact_id": TEST_CONTACT_ID},
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

    db = AwsDynamoApi(setUp_mock_dynamo)
    response = db.delete_contact(delete_event)
    
    assert response["statusCode"] == 200

def test_delete_contact_Failed(setUp_mock_dynamo):
    delete_id = str(uuid4())
    while TEST_CONTACT_ID == delete_id:
        delete_id = str(uuid4())

    delete_event = {
        "pathParameters": {"contact_id": delete_id},
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

    db = AwsDynamoApi(setUp_mock_dynamo)
    response = db.delete_contact(delete_event)
    
    assert response["statusCode"] == 404