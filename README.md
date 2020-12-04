# iGlucose API Test

## Setup

1.  Create a `.env` file and update `IGLUCOSE_API_KEY`

    ```bash
    cp .env.example .env
    ```

    Edit newly created `.env` file:

    ```bash
    vim .env
    ```

    #### .env

    ```bash
    IGLUCOSE_API_ENDPOINT=https://dev.api.iglucose.com
    IGLUCOSE_API_KEY=REPLACE_ME
    ```

    Replace `IGLUCOSE_API_KEY` with a valid development API key.

2.  Build and run the docker image

    ```bash
    docker-compose up --build -d
    ```

## Running Code

1.  Connect to the docker container

    ```bash
    docker exec -it iglucose_api sh -l
    ```

2.  Edit the `payload.json` with the data you want submitted to the development API

    ```json
    {
      "order_number": 1010,
      "customer_name": "Test Customer",
      "customer_id": "1234",
      "address1": "123 Maple Ave",
      "address2": "",
      "city": "Oconomowoc",
      "state": "WI",
      "zipcode": "53066",
      "country": "United States",
      "shipping_method": "MAIL",
      "lines": [
        {
          "quantity": "1",
          "sku": "subscript1.2.0",
          "line_name": "iGlucose Blood Glucose Monitoring System (US)"
        }
      ]
    }
    ```

3.  Place a device order by with the following rake task:

    ```bash
    rake iglucose:place_order
    ```

4.  Check the order status with the following rake task:

    You can specify the **order number** from `payload.json` by passing it into the rake task as follows:

    ```bash
    rake iglucose:order_status[order_number]
    ```

    #### Example:

    ```bash
    rake iglucose:order_status[1010]
    ```

## Cleaning Up

Stop and remove containers, networks, images, and volumes

```bash
docker-compose down
```
