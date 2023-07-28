## About

Tea Subscription is a Rails API built to service customers who want to regisister for tea subscriptions. The API allows for calls to be made to create subscriptions, cancel subscriptions and get all subscriptions. <br>
The API requires that the request be sent with a body in JSON format with a "customer_subscription" key. Within this key, a customer email and in some cases a subscription title is accepted in order to complete the request. <br>
All calls will provide customzized error messages if the client email or subscription title sent are incorrect, or the objects do not exist within the database.


## Minimum Viable Product
* An endpoint to subscribe a customer to a tea subscription
* An endpoint to cancel a customer’s tea subscription
* An endpoint to see all of a customer’s subsciptions (active and cancelled)

## Restful API Endpoints
* POST http://localhost:3000/api/v1/customer_subscriptions
- example of required body parameters in JSON format: 
```
  {
   "customer_subscription": 
   {"customer_email": "123@gmail.com",
    "subscription_title": "Platinum"}
  }
```
- example response:
```
{
    "message": "Succesfully created customer subscription"
}
```
* PATCH http://localhost:3000/api/v1/customer_subscriptions_cancel
- example of required body parameters in JSON format: 
```
  {
   "customer_subscription": 
   {"customer_email": "123@gmail.com",
    "subscription_title": "Platinum"}
  }
```
- example response:
```
{
    "message": "Succesfully cancelled customer subscription"
}
```
* GET http://localhost:3000/api/v1/customer_subscriptions
- example of required body parameters in JSON format: 
```
{
   "customer_subscription": 
   {"customer_email": "123@gmail.com"}
}
```
- example response:
```
{
    "data": [
        {
            "id": "1",
            "type": "customer_subscription",
            "attributes": {
                "status": "active",
                "customer_id": 1,
                "subscription_id": 1,
                "subscription": {
                    "id": 1,
                    "title": "Copper",
                    "price": 500,
                    "frequency": "yearly",
                    "created_at": "2023-07-26T21:01:56.981Z",
                    "updated_at": "2023-07-26T21:01:56.981Z"
                }
            }
        },etc...]
}
```
## Gems Utilized
* gem 'faker'
* gem 'jsonapi-serializer'
* gem 'pry'
* gem 'rspec-rails'
* gem 'simplecov'
* gem 'factory_bot_rails'
* gem 'shoulda-matchers'
* gem 'pg'

## Contributors
* Alejandro Lopez: [![Linkedin][linkedin]][alejandro-li-url] [![Github][Github]][alejandro-gh-url]

<!-- MARKDOWN LINKS & IMAGES -->
<!--  -->

[alejandro-li-url]: https://www.linkedin.com/in/alejandrolopez1992/
[alejandro-gh-url]: https://github.com/AlejandroLopez1992
