---
layout: default
---
Tags
====

List tags
--------------

The tags resource returns all tags for the account.

GET `/api/tags.xml`

Sample request:

    curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/tags.xml

Sample XML response:

    <?xml version="1.0" encoding="UTF-8"?>
    <tags type="array">
      <tag>
        <account-id type="integer">5039</account-id>
        <billable type="boolean">true</billable>
        <created-at type="datetime">2009-10-16T09:57:22Z</created-at>
        <id type="integer">23035</id>
        <name>bulk import</name>
        <updated-at type="datetime">2009-10-16T09:57:22Z</updated-at>
      </tag>
      <tag>
        <account-id type="integer">5039</account-id>
        <billable type="boolean">true</billable>
        <created-at type="datetime">2009-10-16T09:04:50Z</created-at>
        <id type="integer">23029</id>
        <name>conf call</name>
        <updated-at type="datetime">2009-10-16T09:04:50Z</updated-at>
      </tag>
    </tags>

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

Freelancers have access to this resource, but will only see tags that are used in assigned projects.
