---
  title: My Projects
---

## Hobby Projects

Most of what I do these days is on
    [Github](https://github.com/reitzig),
including things too minor to list here.

Several drafts and ideas are floating around in my notes space -- stay tuned!

### Current

 * *[chew née ltx2any](https://github.com/reitzig/ltx2any)*
    (2012--)
 
    Yet another {% latex %} build wrapper, with one or two nifty features.
    
    This long-time project used to be driven by my own needs, which
    have -- sadly! -- mostly gone away after leaving academia.
    My intention is to clean it up, {% marginnote "code-quality"
    "As is the way of all code, the more I learn the worse it all looks." %}
    give it a proper name, and release version 1.0. While occasional
    bursts of progress happen, I can not say when (or if, to be honest)
    that release will happen.

 * *[texlogparser](https://github.com/reitzig/texlogparser)*
    (2018)

    A big thorn in my side was the parsing of {% latex %} logs; the
    implementation in ltx2any was abysmal.
    This project is a complete reimplementation, with something like
    an architecture, tests, and CI/CD.

 * *[SDKMAN! for fish](https://github.com/reitzig/sdkman-for-fish)*
    (2018)

    A port of SDKMAN! to the Fish shell. There is not a lot of code here
    since all of the heavy lifting is delegated to the Bash implementation.
    The devil lies in the details.

### Concluded

 * *[Tools for Demon Hunters RPG](https://github.com/reitzig/dh-tools)*
    (2016--2017)
 
    Tools to help GMs and players of the Demon Hunters RPG create useful 
    supplements with little effort. 

 * *[bib2tpl](https://github.com/reitzig/bib2tpl)*
    (2010--2012)
 
    PHP library for creating citation and publication lists from BibTeX.
    
There are a couple of pre-historic projects the code of which never saw the 
light of the internet, and that is probably for the better.
Traces of those *are* still on the net; happy hunting!

## Work Projects

### Ongoing

 * [**HealthDataSpace Access Codes**](https://hdscode.de)
   (2018)

    HDS Access Codes are an easy yet secure way for patients to get
    access to medical data: simply enter the 12-digit code you got from
    your physician.

     - I worked on backend services (Grails, Kotlin) and a library (Java)
       to access them.

 * [**HealthDataSpace SDK**](https://sdk.healthdataspace.org)
   (2017--2018)
 
    Easy access to the features of 
        [HealthDataSpace](https://app.healthdataspace.de) 
    from iOS and macOS apps, providing file storage with certified data 
    privacy for ehealth apps.

    - I co-designed and -implemented the iOS/macOS SDK (Swift) and supported
      development of a matching Android/JVM SDK (Java).
    - I gave a talk titled *Secure Infrastructure for the Mobile Legion*
      at
        [eHealth Innovation Days 2017](https://ehealth-innovation.net/history/ehealth-innovation-days-2017.html). 
        
      -- [slides](/assets/pdf/ehid2017.pdf) -- 
      [slides with notes](/assets/pdf/ehid2017-notes.pdf) --

### On Hiatus

 * **Tech Talks**

    From November 2017 to early 2018, I organized a roughly bi-weekly series of
    knowledge-transfer sessions (internal).
    I also (co-)held the following sessions:

     * Kotlin -- A hands-on introduction (Jan 12th, 2018)
     * Git -- Basics, demystified (Dec 1st, 2017)