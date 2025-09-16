# README

## Intro

Some of my philosophy: 

1. Get it working, then make it pretty.

2. Get Feedback early

I've invited you to this repository before it is finished.  I believe in opening pull requests at the beginning of a feature build so feedback can be gathered as soon as possible.  For one thing, feedback is easier to take the earlier in development a feature or project is in.  For another, getting feedback at the end which requires a major change is always a bummer. I open PRs as soon as I can to encourage the former and avoid the latter as much as possible.

## Requirements

The MVP seems to be:

* Teachers need to be able to upload files for their students
* The code is deployed somewhere
* Markdown is displayed as HTML
* Students have accounts
  * Since students have accounts we may as well have a class list.
* An admin interface

Beyond that, some prioritized features are:

* Student commenting on files
  * I think this implies a need for some basic content moderation.  If this is for a school, teachers, students, etc we want to make sure we are creating a safe learning environment.
* Version control
* Viewing metrics
* Suggest changes
* An editing interface

## Questions

* How private are these files?
  * Students would need accounts to only view files in their classes.  That's probably not too hard? I'll try that.
* "Each file should be accessible on the public web via a unique URL"
  * That would negate the need for student accounts if all of the files are publically available. I'm going to assume this means "Students can access the files via a link"
  * It's also easier to track metrics this way.
* Do teachers need to be able to edit files in this interface?
  * I'm going to call that out of scope.  Teachers are creating the files in markdown now, so I'm going to assume they have some editing process.
* What kind of supporting files are they uploading?
  * To keep things simple, I'm going to assume they're documents for now.  Videos and other large files may be added later.
* Can teachers be students?
  * We'll let teachers be in a class, but keep the teacher group.  That sounds like something we'll need unit tests for.

## Plan

* Hour 1 - *DONE*
  * Document the plan
  * Document requirements
  * Document questions
  * Create a database schema
* Hour 2 *DONE*
  * Install Devise
  * ~~Create other models from schema~~ We'll do this as needed
  * ~~First deploy to Heroku~~ Waiting on Heroku to fix their outage
  * Install ActiveAdmin
    * Get ActiveAdmin working with users
* Hour 3
  * This was taken up with Hour 2 stuff.
* Hour 4
  * Admin interface for making teachers and other admins
  * Teachers can create a class
* Hour 5
  * Specs for what makes sense
* Hour 6
  * Teachers can upload files
  * First pass at making things pretty
* Hour 7
  * Admin interface
    * File deletion
* Hour 8
  * Content moderation
* Hour 9
* Hour 10
  * Cleanup whatever I can

### Update 1

Sign up/sign in/and sign out work. It was impossible to use without basic navigation so I had to add that in and move it up.  But now the styles are bugging me.  I don't want to spend too long on those but I'll have to do some basic work on that before going much further.

### Update 2

Well, I lied. Instead I got ActiveAdmin working for only admins. I don't seed users yet.  I don't think I want to but I'm not sure what that would make the development experience like.  So I'll punt on that for a bit while I think.

I did not allocate any time for specs.  That's a real bummer.  But the app also needs to do stuff for specs to be worth while.

Fortunately, I have some hours at the end which are unallocated.  So I'll update the plan with what is done and rework what's remaining.


## Development Setup

I'm swiping my [development setup Makefile](https://github.com/MMercieca/dev-setup/blob/main/rails/Makefile).


To check for the necessary development dependencies:

```
make check
```

To install missing dependencies:

```
make install_development
```

## Deployment

I'll deploy to Heroku.

A number of free services were recommended, but I'm not familiar with any of them.  With a Postgres database, Heroku is $10/month--- really it's $5/month since I'm already using a database there. I already have the tools installed to use it. At $100/hour, $5 is three minutes.  I'm going to bet it would take a lot longer than three minutes to set up a free service and it would require some debugging.  Time is my most valuable resource here so I'll opt for using what I know.

To deploy:

`git push heroku <branck>`

## File storage

I'll put the files in S3 because I already have that set up.  ActiveStorage should manage keeping the files as private as we want.

## Database Schema

