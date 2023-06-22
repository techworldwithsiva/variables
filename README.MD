### Variables

Variables is a universal concept in all scripting and programming. It follows DRY principle, don't repeat yourself. Instead of hardcoding the values we can create variables and use them wherever required. If you change the value at one place then it can reflect everywhere it is used.

Terraform have following type of variables.
* Number
* String
* List
* Map
* Bool

Nested Map:
```
variable "servers" {
  type = map(map(string))
  default = {
    "web" = {
      "server1" = "192.168.1.10"
      "server2" = "192.168.1.11"
    }
    "database" = {
      "server1" = "10.0.0.5"
      "server2" = "10.0.0.6"
    }
  }
}
```

Syntax is: 
```
variable "name-of-variable"{
    type = string/number/list/map/bool
    default = "default-value"
    description = "a short description about this"
}
```
How to use variable
```
ami_id = var.ami_id
```

### Count and Count Index

When there is a requirement of creating a same kind of resource multiple times you can use count and count index paramaters instead of creating the same resource multiple times.

count index starts from 0.

### Conditions

When there is a need of taking a decission based on some value we need to use conditions. Usual code of condition is

```
if(expression){
    this code run when expression is true
}
else{
    this code run when expression is false
}
```
in terraform the condition syntax is reduced to single line.
```
condition ? "this will run, if condition is true" : "this will run, if condition is false"
```

### Functions

Functions will do a unit of work, when you call a function it will take 0 or few inputs and give us output, we can call functions whenever we need them.
usual syntax is
```
function-name(inputs){
    run some thing
    return value
}
```
Terraform has built-in functions. It has many numeric, string, file, IP, etc based functions.

### Loops

Loops are required when you want to create a resource multiple times based on a limit. We have 2 types of loops in terraform. Usually we iterate over a list or map and create the resources.
1. Count based loops based on count parameter
2. For each loop