import json
import boto3
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    
    sender = "swe.bitbybit@gmail.com"
    
    recipient = "swe.bitbybit@gmail.com"

    client = boto3.client('ses', region_name='eu-south-1') 

    subject = "SOS - Richiesta di Emergenza"
    
    body_text = "L'utente ha premuto il pulsante di Emergenza SOS. Mettiti subito in contatto."
    
    body_html = """<html>
    <head></head>
    <body>
      <h1 style='color:red;'>Richiesta di Emergenza</h1>
      <p>L'utente ha premuto il pulsante di Emergenza.</p>
      <p>Questa è un'email generata automaticamente dall'app per il test del POC.</p>
    </body>
    </html>
    """            
                 
    try:
        response = client.send_email(
            Destination={
                'ToAddresses': [recipient], 
            },
            Message={
                'Body': {
                    'Html': {
                        'Charset': "UTF-8",
                        'Data': body_html,
                    },
                    'Text': {
                        'Charset': "UTF-8",
                        'Data': body_text,
                    },
                },
                'Subject': {
                    'Charset': "UTF-8",
                    'Data': subject,
                },
            },
            Source=sender,
        )
    except ClientError as e:
        error_msg = e.response['Error']['Message']
        print(f"Errore durante l'invio: {error_msg}")
        return {
            'statusCode': 400,
            'body': json.dumps({'error': error_msg})
        }
    else:
        msg_id = response['MessageId']
        print(f"Email inviata con successo! Message ID: {msg_id}")
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Email inviata con successo!',
                'message_id': msg_id
            })
        }

if __name__ == "__main__":
    test_event = {}
    
    print("Avvio il test locale della funzione Lambda...")
    risultato = lambda_handler(test_event, None)
    print("Risultato:", risultato)
