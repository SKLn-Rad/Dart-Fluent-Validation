# Fluent Validation
This is a port of the C# variant as can be seen at [This Link](https://fluentvalidation.net/)

The goal with this was to decouple the UI validation as seen in Flutters TextFields and use a more common and readable standard. It is still very much beta so please give it a go and give me your feedback.

```dart
class UserValidator extends AbstractValidator<User> {
	UserValidator() {
		ruleFor((user) => user.age).isNotNull().greaterThanOrEqual(13);
		ruleFor((user) => user.name).isNotEmpty();
	}
}

// Later on
final UserValidator validator = UserValidator();
ValidationResult result = validator.validate(user);
```

## Features
1) Built in validators (Most included, as well as some extra ones)
2) Custom validators (Only supported through the 'must' matcher at the moment)
3) Localisation (Not done yet)

## Built in Validators
* isNull - (checks the object is null)
* isNotNull - (checks the object is not null)
* notEmpty - (checks the object is a String and not empty)
* empty - (checks the object is a String and is empty)
* notEqual - (checks if an object is not equal to another)
* equal - (checks if an object is equal to another)
* length - (checks the object is a String and is between two other numbers)
* minLength - (checks the object is a String and is of a minimum length)
* maxLength - (checks the object is a String and is at least of a maximum length)
* lessThan - (checks the object is a number and is less than another number)
* lessThanOrEqual - (checks the object is a number and is less than or equal to another number)
* greaterThan - (checks the object is a number and is greater than another number)
* greaterThanOrEqual - (checks the object is a number and is greater than or equal to another number)

## Extra Built In Validators
These are not included in the default C# version.  
* isValidEmailAddress - (checks the object is a String and is a valid email address)
* isValidPhoneNumber - (checks the object is a String and is a valid phone number)
* isValidNationalInsuranceNumber - (checks the object is a String and is a valid UK national insurance number)
* isValidUKPostCode - (checks the object is a String and is a valid UK post code)

## Contributing
Feel free to do a pull request with any ideas and I will check each one.
¬ Rad