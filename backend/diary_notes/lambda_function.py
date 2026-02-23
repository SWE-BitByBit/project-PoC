import boto3
import os

from AwsDynamoS3Api import AwsDynamoS3Api

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table(os.environ["TABLE_NAME"])

    s3_client = boto3.client("s3")

    awsClient = AwsDynamoS3Api(table, s3_client)

    route = event.get("routeKey")

    if route == "PUT /notes":
        return awsClient.add_note(event)
    elif route == "GET /notes":
        return awsClient.list_notes(event)