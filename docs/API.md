# Diary notes

## `PUT \notes`
Crea una nuova nota con testo e/o immagine.
### Request Body (application/json)
```json
{
  "message": "string (optional)",
  "fileName": "string (optional)"
}
```
#### Vincoli
Deve essere presente almeno uno tra
- `message`
- `fileName`

## `GET /notes`
Restituisce tutte le note dell'utente autenticato.
### Response `200`
```json
[
  {
    "id": "uuid",
    "message": "string",
    "created_at": "ISO-8601",
    "presigned_url": "string (optional)"
  }
]
```