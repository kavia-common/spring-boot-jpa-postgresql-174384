This directory must contain maven-wrapper.jar so that ./mvnw works without needing to download the downloader.

Note for repository/CI:
- The file .mvn/wrapper/maven-wrapper.jar should be committed to the repository.
- Since binary files cannot be embedded via this interface, please ensure the following file is added to VCS:
  .mvn/wrapper/maven-wrapper.jar

You can regenerate/add it with:
  ./mvn -N io.takari:maven:wrapper -Dmaven=3.9.9
or copy from a known-good project.

Without this jar, the wrapper will attempt a network download per the mvnw script.
