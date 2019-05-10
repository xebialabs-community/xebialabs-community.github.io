### Welcome to XebiaLabs Community Plugins
This page describes how you can contribute to the [XebiaLabs](https://xebialabs.com/) community plugins, where the continuous integration is located and what steps to follow to release your community plugin.

_To join the xebialabs-community organization, create a [GitHub](https://github.com/join) account and request to join the organization by sending an email to [rbroker@xebialabs.com](mailto:rbroker@xebialabs.com) and [amohleji@xebialabs.com](mailto:amohleji@xebialabs.com)._

### Quickstart for Existing Plugins

If you want to contribute to an existing repository, simply fork the repository, make your changes, and send a pull request.
If you need help with this, contact an existing plugin contributor - for example the person who last committed to that repository.

## Plugin Setup

### License

XebiaLabs requires that each plugin use the [MIT license](https://opensource.org/licenses/MIT):

```
Copyright <YEAR> <COPYRIGHT HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

Licensing can be easily handled using the [Gradle license plugin](https://github.com/hierynomus/license-gradle-plugin):

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
We have a public artifact repository which Gradle or Maven can use to fetch dependencies. It is located at <a href="https://dist.xebialabs.com/public/maven2">https://dist.xebialabs.com/public/maven2</a>. A Gradle configuration which uses the repository would look like this:

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
XebiaLabs uses Travis CI for continuous integration. Go to [Travis CI](https://travis-ci.org) and log in with your GitHub account. After you log in, you'll see the community plugins being built. The build configuration is provided by the `.travis.yml` file in each repository. More information is available at the [Travis CI documentation site](http://docs.travis-ci.com/).

When creating the `.travis.yml` file, please configure [Slack](https://slack.com/) notifications as described [here](https://docs.travis-ci.com/user/notifications/#configuring-slack-notifications)  and GitHub releases as described [here](http://docs.travis-ci.com/user/deployment/releases/).  Use the XebiaLabsCommunityCI system account for GitHub keys.

#### Circle CI
As an alternative, you can use Circle CI.

### Gradle Wrapper
Using a Gradle wrapper ensures that the same Gradle version is used for all builds (including on Travis CI). An example Gradle wrapper can be found in [the xld-openshift-plugin repository](https://github.com/xebialabs-community/xld-openshift-plugin). You can copy the example wrapper or create one yourself using `gradle wrapper`.

Builds should typically be ran with `./gradlew build`.

## Release Outline

### Versioning - Manual/Basic

* Update the `build.gradle` file to contain the new version number.
* Update the `.travis.yml` file to contain the new version number.
* Create a new tag, using [semantic versioning](https://semver.org).
   * For example: `git tag -a v4.5.2 -m 'Version 4.5.2' 373159` for commit 373159.
* Push the tag to GitHub: `git push --follow-tags`.

### Versioning - Nebula and Travis

Nebula eliminates the need to set and/or change the version number in the Gradle file.  The Travis build will use the version number set in the commit tag.  The tags in the repository must be set appropriately by the developer for a major, minor, or patch release using the Nebula conventions.

#### Gradle Config

* Add ```id 'nebula.release' version '6.0.0'``` to the ```plugins``` section of the `build.gradle` file.
* Remove the hard-coded version assignment if present.
* Add scope and useLastTag logic.  Note, if it appears that Gradle is not processing these lines, move them higher in the build.gradle file.  See the history of the build.gradle file in <https://github.com/xebialabs-community/xlr-ansible-tower-plugin> for an example.

```
if (!project.hasProperty('release.scope')) {
  project.ext['release.scope'] = 'patch'
}
if (!project.hasProperty('release.useLastTag')) {
  project.ext['release.useLastTag'] = true
}
```

#### Nebula Compatibility of Existing Tags

Check that existing tags meet Nebula conventions.  The tag format should be vx.y.z, where x = major release number, y = minor release number, z = patch level.  See the Semantic Versioning reference at <https://semver.org>.

#### Travis Config

Edit the .travis.yml file:
* The Travis gem can be installed with ```gem install -v 1.7.5 --no-rdoc --no-ri travis```.  
* If the api_key credentials are not working, generate new ones with ```travis setup releases --force``` and the XebiaLabsCommunityCI system account.  
* Add ```file_glob:  true``` to allow wildcards in the `file:` argument(s).  
* Set or change `file` to ```build/distributions/*``` or ```build/libs/*```.  The argument can point to a single file (with or without wildcards) or list of files in yml notation.
* Add ```skip_cleanup:  true```, so the cleanup doesn't delete the file to be uploaded.
* Add ```on:``` block  
```all_branches:  true```    
```tags:  true```  
```repo:  repo-owner/repo-name```  

* Also, ```before_deploy:``` and ```after_deploy:``` blocks are available to run scripts before/after release is pushed.
* Turn on the switch for the repository at https://travis-ci.org/profile/xebialabs-community.

Example:

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

#### New Releases

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

* Confirm a successful build in your local directory.
* Commit the code changes in your local directory, then push them to the GitHub repository.
* Set the [appropriate tag](https://semver.org), e.g., ```git tag -a "v1.3.0" -m "Version 1.3.0"``` for the last commit.
* Execute ```git push --follow-tags```.
* Each push will trigger a Travis job; the second job will add the files listed to the repository's Releases page.
* Consider editing the release notes in GitHub to provide better insight into what's included/important for this release.

## Definition of Done

* Each repository must include the MIT license.
* Each repository must have a description.
* Each repository must have one or more GitHub topics defined.
* If your repository is a plugin, the repository name should end with `plugin`.
* If your repository is a plugin for XL Deploy, the repository name should start with `xld`.
* If your repository is a plugin for XL Release, the repository name should start with `xlr`.
* Each repository must have public CI enabled (Travis, CircleCI, or other) and the corresponding badge in the `README.md` file.

## Extra Information

* [XebiaLabs website](https://xebialabs.com/)
* [XebiaLabs documentation](https://docs.xebialabs.com/)
* [XebiaLabs support](https://support.xebialabs.com)
* [XebiaLabs community](https://github.com/xebialabs-community)