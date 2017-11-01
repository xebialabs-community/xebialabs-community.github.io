### Welcome to XebiaLabs Community plugins
This page describes how you can contribute to the [XebiaLabs](https://xebialabs.com/) community plugins, where the continuous integration is located and what steps to follow to release your community plugin.

### Join the xebialabs-community organization
Create a [GitHub](https://github.com/join) account, and request to join the organization by sending an email to jdewinne@xebialabs.com.

### Fork a repo or generate a pull request
If you want to contribute to an existing repository, simply fork the repository, make your changes, and send a pull request.
If you need help with this, you can contact for example the person who last committed to that repository.

### License to be used
XebiaLabs requires each plugin to include the following [license information](https://opensource.org/licenses/MIT):

```
Copyright <YEAR> <COPYRIGHT HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

This can easily be done using the [Gradle license plugin](https://github.com/hierynomus/license-gradle-plugin):

```
plugins {
    id "com.github.hierynomus.license" version "0.13.1"
}
...
license {
  header rootProject.file('License.md')
  strictCheck false
  ext.year = Calendar.getInstance().get(Calendar.YEAR)
  ext.name = 'XEBIALABS'
}
```

### Dependencies
We have a public artifact repository which Gradle or Maven can use to fetch dependencies. It is located at <a href="https://dist.xebialabs.com/public/maven2">https://dist.xebialabs.com/public/maven2</a>. For example, to configure Gradle to use it:

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
As an alternative, you can use Circle CI.

### Use a Gradle wrapper
Using a Gradle wrapper ensures that the same Gradle version is used (including on Travis CI). An example usage of a Gradle wrapper can be found in [the xld-openshift-plugin repository](https://github.com/xebialabs-community/xld-openshift-plugin). You can copy the example wrapper or create one yourself using `gradle wrapper`.

### Release your plugin
Make sure you follow these steps

* Update the `build.gradle` file to contain the new version number.
* Update the `.travis.yml` file to contain the new version number.
* Create a new tag. For example: `git tag -a v4.5.2 -m 'Version 4.5.2' 373159`.
* Push the tag to GitHub: `git push --follow-tags`.

### Rules to follow - Definition of Done

* Each repository must include the MIT license.
* Each repository must have a description.
* Each repository must have one or more GitHub topics defined.
* If your repository is a plugin, the repository name should end with `plugin`.
* If your repository is a plugin for XL Deploy, the repository name should start with `xld`.
* If your repository is a plugin for XL Release, the repository name should start with `xlr`.
* Each repository must have public CI enabled (Travis, CircleCI, or other) and the corresponding badge in the `README.md` file.

### Extra information

* [XebiaLabs website](https://xebialabs.com/)
* [XebiaLabs documentation](https://docs.xebialabs.com/)
* [XebiaLabs support](https://support.xebialabs.com)
* [XebiaLabs community](https://github.com/xebialabs-community)
