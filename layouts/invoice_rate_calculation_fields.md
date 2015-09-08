
rate_calculation
: *Optional* **object**
: How to calculate the total amount for hours worked. The fields are:

    calculation_method
    : *Required* **string**
    : What method will be used to calculate the total amount for hours worked. Accepted values are:

        * `standard_hourly_rate`: a single hourly rate is used across the entire invoice.
        * `custom_hourly_rates`: custom hourly rates can be defined for individual users in the `custom_hourly_rates` array. If no `custom_hourly_rate` is defined for an individual user, the `standard_hourly_rate` is used for that user.
        * `flat_rate`: a flat rate is used for the the total cost of the hours in the invoice.

    flat_rate
    : *Required if payment_type equals `flat_rate`* **decimal**
    : The flat rate used as the total amount for hours worked.

    standard_hourly_rate
    : *Required if `calculation_method` equals `standard_hourly_rate` or `custom_hourly_rate`* **decimal**
    : The standard hourly rate used to calculate the total amount for hours worked.

    custom_hourly_rates
    : *Required if `calculation_method` equals `custom_hourly_rate` (ignored otherwise)* **array of objects**
    : The custom hourly rates for users, which are used to calculate the total amount for the hours they worked in this invoice. The fields are:

        user_id
        : *Required* **integer**
        : the ID of the user

        hourly_rate
        : *Required* **decimal**
        : the hourly rate for this specific user.