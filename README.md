### Welcome to XebiaLabs Community plugins
This page describes how you can contribute to the [XebiaLabs](https://xebialabs.com/) community plugins, where the continuous integration is located and what steps to follow to release your community plugin.

### Join the xebialabs-community organization
Create a [GitHub](https://github.com/join) account, and request to join the organization by sending an email to jdewinne@xebialabs.com.

### Fork a repo or generate a pull request
If you want to contribute to an existing repository, simply fork the repository, make your changes and send a pull request.
If you need help with this, you can contact for example the person who last committed to that repository.

### License to be used
XebiaLabs requires each plugin to include the following license information:

```
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS 
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
```

This can easily be done using the [Gradle license plugin](https://github.com/hierynomus/license-gradle-plugin)

```
plugins {
    id "com.github.hierynomus.license" version "0.12.1"
}

...

license {
    header rootProject.file('src/main/license/xebialabs_community.license')
    strictCheck true
}
```

### Dependencies
We have a public artifact repository which can be used by gradle or maven to fetch dependencies. It can be found here `https://dist.xebialabs.com/public/maven2`. For example this is how to configure gradle to use it:

```
repositories {
  ...
  maven {
    url 'http://dist.xebialabs.com/public/maven2'
  }
}
```

### Continuous Integration
#### Travis CI
XebiaLabs uses Travis CI for continuous integration. Go to [Travis CI](https://travis-ci.org) and log in with your GitHub account. After you log in, you'll see the community plugins being built. The build configuration is located in the `.travis.yml` file in each repository. More information is available at the [Travis CI documentation site](http://docs.travis-ci.com/).

Please also configure [HipChat](https://hipchat.com/) notifications as described [here](http://docs.travis-ci.com/user/notifications/#HipChat-notification) (TravisCI room) and GitHub releases as described [here](http://docs.travis-ci.com/user/deployment/releases/).

#### Circle CI
As an alternative you can also use Circle CI.

### Use a gradle wrapper
Using a Gradle wrapper ensures that the same Gradle version is used (including on Travis CI). An example usage of a Gradle wrapper can be found in [the xld-openshift-plugin repository](https://github.com/xebialabs-community/xld-openshift-plugin). You can copy the example wrapper or create one yourself using `gradle wrapper`.

### Release your plugin
Make sure you follow these steps

* Update the `build.gradle` file to contain the new version number.
* Update the `.travis.yml` file to contain the new version number.
* Create a new tag. Example `git tag -a v4.5.2 -m 'Version 4.5.2' 373159`.
* Push the tag to github: `git push --follow-tags`.

### Rules to follow

* Each repository must include the license.
* If your repository is a plugin, the repository name should end with `plugin`.
* If your repository is a plugin for XL Deploy, the repository name should start with `xld`.
* If your repository is a plugin for XL Release, the repository name should start with `xlr`.

### Extra information

* [XebiaLabs website](https://xebialabs.com/)
* [XebiaLabs documentation](https://docs.xebialabs.com/)
* [XebiaLabs support](https://support.xebialabs.com)
* [XebiaLabs community](https://github.com/xebialabs-community)
