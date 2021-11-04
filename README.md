# Design as Code Example

This respository contains an example of using the `design-as-code` tool to build an application information repository in AWS S3.

The solution uses AWS Athena to provide a query layer, which is then accessed via Qliksense Cloud to produce some dashboards.

You can see the design-as-code solution here: https://github.com/richardjkendall/design-as-code.

Each push to this repo triggers a github action which runs the design-as-code tool and pushes the results to S3, it also triggers a Qlik Reload via the REST API.
