import json
from uuid import uuid4
from boto3.dynamodb.conditions import Key

class AwsDynamoApi:
    def __init__(self, table):
        self.table = table

    def response(self, status, body):
        return {
            "statusCode": status,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(body)
        }

    def add_contact(self, event):
        body = json.loads(event["body"])
        contact_id = str(uuid4())
        name = body["name"]
        email = body["email"]
        contact = {
            "user_email": event["requestContext"]["authorizer"]["claims"]["email"],
            "id": contact_id,
            "name": name,
            "email": email
        }

        self.table.put_item(Item=contact)
        return self.response(
            201,
            {
                "id": contact_id,
                "name": name,
                "email": email
            }
        )

    def get_contact(self, event):
        contact_id = event["pathParameters"]["contact_id"]

        response = self.table.get_item(
            Key={
                "user_email": event["requestContext"]["authorizer"]["claims"]["email"],
                "id": contact_id
            }
        )
        item = response.get("Item")
        if not item:
            return self.response(404, {"msg": "Not found"})

        return self.response(200, item)

    def delete_contact(self, event):
        contact_id = event["pathParameters"]["contact_id"]
        try:
            response = self.table.get_item(
                Key={
                    "user_email": event["requestContext"]["authorizer"]["claims"]["email"],
                    "id": contact_id
                }
            )
            
            item = response.get("Item")
            if not item:
                raise KeyError("Item not found")
            
            self.table.delete_item(
                Key={"user_email": event["requestContext"]["authorizer"]["claims"]["email"], "contact_id": contact_id}
            )
            return self.response(200, {"msg": "Deleted"})
        
        except KeyError:
            return self.response(404, {"msg": "Not found"})
    
    def list_contacts(self, event):
        response = self.table.query(
            KeyConditionExpression=Key("user_email").eq(event["requestContext"]["authorizer"]["claims"]["email"])
        )
        return self.response(200, response["Items"])