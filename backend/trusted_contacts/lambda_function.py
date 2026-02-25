import boto3
import os
from AwsDynamoApi import AwsDynamoApi

def lambda_handler(event, context):
    dynamodb = boto3.resource("dynamodb")
    table = dynamodb.Table(os.environ["TABLE_NAME"])

    db =  AwsDynamoApi(table)

    route = event.get("routeKey")

    if route == "PUT /contacts":
        return db.add_contact(event)
    elif route == "GET /contacts/{contact_id}":
        return db.get_contact(event)
    elif route == "DELETE /contacts/{contact_id}":
        return db.delete_contact(event)
    elif route == "GET /contacts":
        return db.list_contacts(event)

    return {
        "statusCode": 400,
        "body": "Unsupported route"
    }
