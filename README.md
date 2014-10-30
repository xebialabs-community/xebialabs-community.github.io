### Welcome to XebiaLabs Community plugins
This page describes how you can contribute to the XebiaLabs Community plugins, where the continuous integration is located and what steps to follow to release your community plugin.

### Join the xebialabs-community organization
Create a github account, and request to join the organization by sending an email to jdewinne@xebialabs.com.

### Fork a repo or generate a pull request
If you want to contribute to an existing repository, simply fork the repository, make your changes and send a pull request.
If you need help on this, you can contact for example the person who has done the latest commits to that repository.

### License to be used
Currently we want each plugin to have the following license information maintained:

```
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS 
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
```

This can easily be done using the gradle license plugin https://github.com/hierynomus/license-gradle-plugin

```
buildscript {
  repositories {
    jcenter()
  }
  dependencies {
    classpath "nl.javadude.gradle.plugins:license-gradle-plugin:0.11.0"
  }
}

apply plugin: "com.github.hierynomus.license"
```


### Continuous Integration
We use travis ci as Continuous Integration tool. You can simply browse to https://travis-ci.org and login via your github account. Once logged in, you'll see all our community plugins being build. The configuration for that can be found in the `.travis.yml` file within each repository.
More information can be found at http://docs.travis-ci.com/

### Use a gradle wrapper
An example usage of a gradle wrapper can be found in the xld-cloudfoundry-plugin repository. Using a gradle wrapper makes sure we are always using the same gradle version, also on Travis. You can copy the example wrapper from the xld-cloudfoundry-plugin repository or create one yourself using `gradle wrapper`.

### Release your plugin
Make sure you follow these steps

* Update the `build.gradle` file to contain the new version number
* Update the `.travis.yml` file to contain the new version number
* Create a new tag. Example `git tag -a v4.5.2 -m 'Version 4.5.2' 373159`
* Push the tag to github: `git push --tags`

### Rules to follow

* Each repository must have the license somewhere included
* If your repository is a plugin, the repo name should end with `plugin`
* If your repository is a plugin for XL Deploy, it should start with `xld`
* If your repository is a plugin for XL Release, it should start with `xlr`
