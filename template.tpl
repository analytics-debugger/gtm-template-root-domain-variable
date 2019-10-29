___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Root Domain",
  "description": "Current URL Root Domain value",
  "categories": ["UTILITY"],
  "containerContexts": [
    "WEB"
  ],
  "brand": {}
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "message",
    "displayName": "No configuration required."
  }
]


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmTestCookie"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "/"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtmTestCookie"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// David Vallejo . Oct 2019
// Custom Variable Template to grab the current domain root

// Needed Libraries
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getUrl = require('getUrl');

// Our Test cookie name
const testCookieName = 'gtmTestCookie';

// The function where the magic happens
const getRootDomain = function() {
  let domain = getUrl('host');
  const domParts = domain.split('.');       
  let rootDomain = null;
  
  if (domain.substring(0, 4) == "www.") {
    domain = domain.substring(4, domain.length);
  }
  
  for (var i = 1; i <= domParts.length; i++) {
	rootDomain = domParts.slice(i*-1).join('.');    
    setCookie(testCookieName, '2', {
      'domain': rootDomain,
      'path': '/',
      'max-age': 1,
      'secure': true
    });
    if(getCookieValues(testCookieName).length>0){
       return rootDomain;      	   
    }
  }  
};
// Return a value
return getRootDomain();


___NOTES___

Created on 10/29/2019, 6:38:35 PM
