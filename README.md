### Welcome to XebiaLabs Community plugins
This page describes how you can contribute to the [XebiaLabs](https://xebialabs.com/) community plugins, where the continuous integration is located and what steps to follow to release your community plugin.

### Join the xebialabs-community organization
Create a [GitHub](https://github.com/join) account, and request to join the organization by sending an email to rbroker@xebialabs.com and amohleji@xebialabs.com.

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

### Release your plugin (general outline)
Make sure you follow these steps

* Update the `build.gradle` file to contain the new version number.
* Update the `.travis.yml` file to contain the new version number.
* Create a new tag. For example: `git tag -a v4.5.2 -m 'Version 4.5.2' 373159`.
* Push the tag to GitHub: `git push --follow-tags`.

### Release your plugin with Gradle, Nebula, and Travis

Nebula eliminates the need to set and/or change the version number in the Gradle file.  The Travis build will use the version number set in the commit tag.  The tags in the repo must be set appropriately by the developer for a major, minor, or patch release using the Nebula conventions.

#### Check that existing tags meet Nebula conventions.  
* The tag format should be vx.y.z, where x = major release number, y = minor release number, z = patch level.  See the Semantic Versioning reference at <https://semver.org>.

#### Edit the .travis.yml file.  
* If the api_key credentials are not your own, set yours with ```travis setup releases --force```.  
* The Travis gem can be installed with ```gem install -v 1.7.5 --no-rdoc --no-ri travis```.  
* Add ```file_glob:  true``` to allow wildcards in the file: argument(s).  
* Set or change file to ```build/distributions/*``` or ```build/libs/*```.  The argument can point to a single file (with or without wildcards) or list of files in yml notation.
* Add ```skip_cleanup:  true```, so the cleanup doesn't delete the file to be uploaded.
* Add ```on:``` block  
```all_branches:  true```    
```tags:  true```  
```repo:  repo-owner/repo-name```  

* Also, ```before_deploy:``` and ```after_deploy:``` blocks are available to run scripts before/after release is pushed.
* Turn on the repository switch for the repo at https://travis-ci.org/profile/xebialabs-community.

* Example:

```
deploy:
  provider:  releases
  api_key:
    secure:  ...
  file_glob:  true
  file:  build/distributions/*
  skip_cleanup:  true
  on:
    all_branches:  true
    tags:  true
    repo:  repo-owner/repo-name
```

#### Edit the build.gradle file.
* Add ```id 'nebula.release' version '6.0.0'``` to ```plugins```.
* Remove the hardcoded version assignment if present.
* Add scope and useLastTag logic.  Note, if it appears that Gradle is not processing these lines, move them higher in the build.gradle file.  See the history of the build.gradle file in <https://github.com/xebialabs-community/xlr-ansible-tower-plugin> for an example.
  
```
if (!project.hasProperty('release.scope')) {
  project.ext['release.scope'] = 'patch'
}
if (!project.hasProperty('release.useLastTag')) {
  project.ext['release.useLastTag'] = true
}
```

* Confirm a successful build in your local directory with ```./gradlew build``.
* Commit all pending changes in your local directory.
* Execute ```git push```.
* Set the appropriate tag, e.g., ```git tag -a "v1.3.0" -m "Version 1.3.0"```.
* Execute ```git push --follow-tags```.
* Each push will trigger a Travis job; the second job will add the files listed to the repository's Releases page.


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
