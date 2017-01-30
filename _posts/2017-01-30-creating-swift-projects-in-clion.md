---
  title: "Creating Swift Projects in CLion"
  tags: [Swift, IDE, Tools]
  mathjax: false
  categories: dev
---

{% newthought "Swift" %} is a modern language with a little teething trouble,
but it is still worth a look. 
If you are like me and you do not want to work on a Mac if you can avoid it, 
your choices of development environments are rather limited at this point. 
Here, I explain how to create a Swift project with
  [Jetbrains' CLion](https://www.jetbrains.com/clion/),
for which Jetbrains develops a Swift plugin.

*Note bene:* The need for this workaround may go away soon;
Jetbrains plans to 
  [support the Swift workflow better](https://youtrack.jetbrains.com/issue/CPP-8622).

We will create an application project, {% abbr ie %} an executable,
and version it with Git.
You can drop all Git commands if you do not want that.

 1. Follow steps 1--4 from 
      [here](https://blog.jetbrains.com/clion/2015/12/swift-plugin-for-clion/);
    that is, install Swift, CLion, and the Swift plugin for CLion.
    
 2. We set up the project on the command line:
 
    ~~~bash
    mkdir HelloWorld
    cd HelloWorld
    
    git init
    git config user.name "Your Name"
    git config user.email "your@mail.com"
    
    swift package init --type executable
    
    echo -e "cmake-build-debug\n.idea" >> .gitignore
    git add * .gitignore
    git commit -m "Initial commit"
    ~~~
    
    {% flairimg "/assets/posts_img/2017-01-30-clion-swift-folderinit.png" "Initial folder content" %}
    
    You may want to familiarize yourself with the Swift package manager; 
    see
      [here](https://swift.org/getting-started/#using-the-package-manager).
      
 3. Start CLion and import a project from sources;
    select folder `HelloWorld` and mark all files as project files.
    
 4. Delete all run configurations (Run > Edit Configurations...).
    
 5. Open `CMakeLists.txt` and replace the content with the following:
 
    ~~~cmake
    cmake_minimum_required(VERSION 3.6)
    project(HelloWorld)
    set(CMAKE_CXX_STANDARD 11)

    set(SOURCEDIR Sources)
    set(TESTDIR Tests)
    set(BUILDDIR .build/debug)

    file(GLOB_RECURSE SOURCE_FILES ${SOURCEDIR}/*.swift Package.swift)
    file(GLOB_RECURSE TEST_FILES ${TESTDIR}/*.swift)

    add_custom_target(Build
            COMMAND swift build -v
            BYPRODUCTS .build
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            SOURCES ${SOURCE_FILES})

    add_custom_target(Test
            COMMAND swift test -v
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            SOURCES ${SOURCE_FILES} ${TEST_FILES}
            )

    add_custom_target(Run
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            SOURCES ${SOURCE_FILES}
            ) 
    ~~~
 
    When the notification 
    
    > CMake project needs to be reloaded
    
    pops up, click "Enable Auto-Reload" to avoid confusion down the line.
    
 6. On the command-line, execute:
    
    ~~~bash
    git add CMakeLists.txt
    git commit -m "Adds CMakeLists"
    ~~~
    
 7. Run all the build configurations. CLion will complain that they have no
    executable set; select `/bin/echo` or a similar no-op for `Build` and `Test`,
    and `.build/debug/HelloWorld` for `Run`.
    
    {% flairimg "/assets/posts_img/2017-01-30-clion-swift-runconfig.png" "The Build configuration" %}
    
 8. Via the context menu in the project view,
    mark `.build` as "Excluded", 
    and `Sources` as "Project Sources and Headers".
    
    {% flairimg "/assets/posts_img/2017-01-30-clion-swift-projectview.png" "The complete project" %}
 
All done!
Note that this is not perfect, though:

 * CLion actions do not map to these custom targets in a helpful way.
 * The Clean action does not clean `.build`.
 * `Run` does not rebuild automatically.
 
I appreciate any comments on how to improve this setup!
