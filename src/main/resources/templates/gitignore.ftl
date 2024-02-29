
# 查看更多 .gitignore 配置 -> https://help.github.com/articles/ignoring-files/

target/
!.mvn/wrapper/maven-wrapper.jar

Test*.java

### STS ###
.apt_generated
.classpath
.factorypath
.project
.settings
.springBeans
.sts4-cache

### IntelliJ IDEA ###
.idea
*.iws
*.iml
*.ipr
*.class
target/*

### NetBeans ###
/nbproject/private/
/nbbuild/
/dist/
/nbdist/
/.nb-gradle/
/build/



### admin-web ###

# dependencies
**/node_modules

# roadhog-api-doc ignore
/src/utils/request-temp.js
_roadhog-api-doc

# production
/dist
/.vscode

# misc
.DS_Store
npm-debug.log*
yarn-error.log

/coverage
.idea
yarn.lock
package-lock.json
*bak
.vscode

# visual studio code
.history
*.log

functions/mock
.temp/**

# umi
.umi
.umi-production

# screenshot
screenshot
.firebase
sessionStore

.flattened-pom.xml
