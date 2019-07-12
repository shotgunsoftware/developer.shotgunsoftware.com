---
layout: default
title: Webhooks
pagename: shotgun-webhooks
lang: en
---

# Webhooks

Webhooks allow you to be notified of events that occur in Shotgun. When you create a webhook, you specify the type of event you are interested in and tell Shotgun what URL to send data to when it is triggered. Once the relevant event happens in Shotgun, a payload of data describing the event will be sent to the webhook’s URL. This allows you to build tight integrations with Shotgun and automate portions of your workflow.

## What are some examples of how to use webhooks?

There are numerous use cases for webhooks. A few that we think are compelling are outlined in this document, but their uses are by no means limited to these few examples.

### Create a directory structure on disk when an entity is created

One workflow that we have seen repeated many times over is the need to create a directory structure on disk when a new entity is created in Shotgun. Why not go ahead and make sure that new Shot is ready for artist work automatically once it is created in Shotgun?

### Automation of status management

When your animation team is finished with their work, why not go ahead and change the status of downstream Tasks in the same Shot to indicate that more work is ready to begin? This way, you can automatically notify the assigned artists in different disciplines that everything is ready to go!

Another great example of how to automate status management would be to trigger a status change on a Task when a new Note is created. This is a good way to indicate to the artist and production teams that a supervisor has requested changes or fixes to the current work after a review session.

## Creating a webhook

To get started creating a webhook, navigate to the button above the webhooks list.

### The webhook creation dialog

Next up is to fill out the necessary information required to create the new webhook.

#### Secret token

Assigning a secret token to a webhook is optional. If provided, any request sent to the webhook URL will be signed using that token. The token value is sent with the request as a header named `X-SG-SIGNATURE`. The signature is calculated using HMAC with SHA1 and the message signed is the JSON body of the request.

##### Header format

`<algorithm>=<signature>`

##### Why use a secret token?

While not strictly required, providing a secret token causes the payload sent to the webhook URL to be signed. This allows the consumer service to verify that the data originated from the source it expects, and that the payload has not been altered in any way during transit.

##### Signature verification

An example of how to verify the signature of the payload is provided below using Python.

```python
>>> import hmac
>>> import hashlib
>>> body | `<json body>'
>>> token | `mytoken'
>>> 'sha1=' + hmac.new(token, body, hashlib.sha1).hexdigest()  == 'sha1=32824e0ea4b3f1ae37ba8d67ec40042f3ff02f6c'
True
```

#### Verify SSL certificate

Verification of SSL certificates is an optional feature that will help ensure the security of any connections made to the webhook’s consumer URL. If turned on, when a delivery is made to the webhook’s URL, Shotgun will use OpenSSL’s certificate validation routine to verify the certificate.

## Webhook status

A webhook can have one of several different statuses, indicating its health and ability to continue receiving deliveries.

| Status | Description | Example |
|--------|:-----------:|--------:|
| Active | The webhook is operating in a stable fashion. No deliveries to this webhook have failed to reach their destination in the past 24 hours. | **TODO** |
| Unstable | The webhook is operating in an unstable fashion. Some deliveries have failed to reach their destination in the past 24 hours, but not enough to cause Shotgun to consider the webhook to be dead. | **TODO** |
| Failed | The webhook is considered to be dead, and no further deliveries will be attempted. This is a result of too many delivery failures in a short period of time, and the system has determined that the webhook should no longer be considered viable. **A webhook is considered failed if it has 10 failed deliveries in the past 24 hours**. | **TODO** |
| Disabled | The webhook is in a disabled state, and no further deliveries will be attempted until it is re-enabled. | **TODO** |

## Deliveries

Selecting a webhook in the webhooks list will show all of the deliveries that have been made for that webhook dating back as far as 5 days ago. Delivery logs older than 5 days are removed and are not recoverable.

### Delivery status

A delivery’s status indicates whether it was successfully delivered to the webhook’s URL.

### Delivery details

Deliveries can be expanded to show detailed information about the request sent to the webhook URL and the response to that request.

## Testing webhooks

You can use any of the freely available webhook URL generators online for testing purposes. These services are specifically intended to be used for testing webhooks and other types of HTTP requests. This is a great way to get started learning about webhooks without needing to set up any infrastructure on your own network.

### Using webhook.site

We recommend [webhook.site](https://webhook.site). It provides a unique URL that can be copied andpasted into a webhook, and will show you deliveries made to that address in real time. The page can be customized to respond to deliveries with a specific status code and body, which means you can test delivery success and failure.

The webhook.site service is aggressively rate limited. This means that it is easy to end up in a situation where some deliveries are rejected, resulting in unstable or failed webhooks. When testing, we recommend that you use a known, controllable project environment rather than live data in production. **It is also not good to send production event data to publicly available, third party web services!**

### Responding to deliveries

A consumer service must respond to deliveries in order for the system to consider them successfully delivered.

#### Status codes

| Status | Code | Description |
|--------|:----:|------------:|
| Success | < 400 | The delivery was received and processed successfully. |
| Error | >= 400 | The delivery was received but was not processed successfully. |
| Redirect | 3xx | The delivery was received, but should be redirected to another URL. |

#### Response time

**A response must be received within 6 seconds of delivery to a webhook’s URL, after which the connection will be closed.** Failure to respond in time will result in a failed delivery. 

### Acknowledgement

*empty until we get JF’s ack workflow changes deployed*

#### What are acknowledgements used for?

*ANSWER THIS*

## Performance and throttling

*empty on purpose until Brandon and I discuss how to explain it in human-readable terms*

