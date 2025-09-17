# README

## Intro

Some of my philosophy: 

1. Get it working, then make it pretty.

This is deployed at [https://alexandria-ebf88031ff5d.herokuapp.com](https://alexandria-ebf88031ff5d.herokuapp.com)

2. Get Feedback early

I've invited you to this repository before it is finished.  I don't expect any early feedback. I wanted to demonstrate part of my development philosophy: get feedback early.  I believe in opening pull requests at the beginning of a feature build so feedback can be gathered as soon as possible.  

For one thing, feedback is easier to take the earlier in development a feature or project is in.  For another, getting feedback at the end which requires a major change is always a bummer. I open PRs as soon as I can to encourage the former and avoid the latter as much as possible.

Again, I'm doing this as a demonstration **only**.

3. Small commits and a good commit story

I do try to keep my commit history clean. That does mean rebasing on occasion. I have to be careful if the whole team isn't doing that, but a senior dev early in my career pointed out how it makes reviewing PRs easier.  I'm doing my best here in the time I have.

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
  * That would negate the need for student accounts if all of the files are publicly available. I'm going to assume this means "Students can access the files via a link"
  * It's also easier to track metrics this way.
* Do teachers need to be able to edit files in this interface?
  * I'm going to call that out of scope for now.  Teachers are creating the files in markdown now, so I'm going to assume they have some editing process.
* What kind of supporting files are they uploading?
  * To keep things simple, I'm going to assume they're documents for now.  Videos and other large files may be added later.
* Can teachers be students?
  * We'll let teachers be in a class, but keep the teacher group.  That sounds like something we'll need unit tests for.
* What devices do I need to support?
  * I doubt teachers are uploading markdown from their phone, so I'll focus on the desktop browser first.  Tailwind is fairly responsive out of the box, but with 10 hours I'm not going to worry about this one overmuch.

## Plan

* Hour 1 - **DONE**
  * Document the plan
  * Document requirements
  * Document questions
  * Create a database schema
* Hour 2 **DONE**
  * Install Devise
  * ~~Create other models from schema~~ We'll do this as needed
  * ~~First deploy to Heroku~~ Waiting on Heroku to fix their outage
  * Install ActiveAdmin
    * Get ActiveAdmin working with users
* Hour 3 **DONE**
  * This was taken up with Hour 2 stuff.
* Hour 4 **DONE**
  * Admin interface for making teachers and other admins
  * Teachers can create a lecture/class
* Hour 5 **DONE**
  * First style pass
* **End of day 1**
* Hour 6 **DONE** --even a bit early
  * Teachers can create assignments
  * Teachers can upload markdown to assignment content
  * Markdown displays as HTML
* Hour 7
  * Teachers can invite students
  * Assignments can be versioned
* Hour 8
  * LectureController specs
  * Teachers can upload supporting files
* Hour 9
  * Content moderation
* Hour 10
  * Cleanup whatever I can

### Update 1

Sign up/sign in/and sign out work. It was impossible to use without basic navigation so I had to add that in and move it up.  But now the styles are bugging me.  I don't want to spend too long on those but I'll have to do some basic work on that before going much further.

### Update 2

Well, I lied. Instead I got ActiveAdmin working for only admins. I don't seed users yet.  I don't think I want to but I'm not sure what that would make the development experience like.  So I'll punt on that for a bit while I think.

I did not allocate any time for specs.  That's a real bummer.  But the app also needs to do stuff for specs to be worth while.

Fortunately, I have some hours at the end which are unallocated.  So I'll update the plan with what is done and rework what's remaining.

### Update 3

Heroku is still investigating their DNS issue.  I expect they'll have it fixed tomorrow.  It's both annoying and incredibly funny that they're having an issue with creating new apps _today_ and _today_ was the day I set aside for starting this project.

I have user management working through ActiveAdmin. I'm thinking that will also be a back door for admins to manage teachers' lectures.  When we get to that.

There's still not a ton that makes sense to spec out, which makes the timeline look a bit iffy. I'll finish out today doing a style pass.

### Update 4

The decision to use Heroku was supposed to make deployment easy. I had a few deployments that worked, but the last one of the day failed.  Oh well, I'll five them the night to fix it before I start worrying.  I won't panic until they haven't fixed it by hours 9 or 10.

I used up my Gemini quota today. I didn't expect to do that as I'm paying for an account and making a relatively small app.  I originally wanted to get more than user management done today, but diving straight in to file uploads tomorrow isn't terrible.

I didn't explicitly say anything about sanitization in my plan.  I'm planning on using Github's markdown to HTML gem for rendering. It looks straightforward enough and has sanitization built in. If this went beyond a prototype I'd add guards.  I still may add demo LLM based guards, but we have to get markdown displaying as HTML and be able to invite classes first.

I also didn't mention email in my plan. For local email I can use the `letter-opener` gem.  I have an account I can send email with and I may hook that up. If I limit sending of email to only teachers and admins I can avoid the security issues somewhat.

### Update 5

The [Heroku incident yesterday](https://status.heroku.com/incidents/2873) lasted 19 hours.  It's resolved now and the app is up at [https://alexandria-ebf88031ff5d.herokuapp.com](https://alexandria-ebf88031ff5d.herokuapp.com)

### Update 6

After I can create and view lectures and assignments, I got to deleting them and that got scary.  So I took a small detour and implemented Paranoid for lectures and assignments. It will save me a bit of time in implementing confirm dialogs when time is short.

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

Once the dependencies are installed, the app can be prepared with with:

```
bundle install
bundle exec rails database:create
bundle exec rails database:migrate
bundle exec rails database:seed

```

(Yeah, I decided to seed the users. Development didn't make sense otherwise.)

Once done, the app can be started with:

```
bin/dev
```

## Deployment

I'll deploy to Heroku.

A number of free services were recommended, but I'm not familiar with any of them.  With a Postgres database, Heroku is $10/month--- really it's $5/month since I'm already using a database there. I already have the tools installed to use it. At $100/hour, $5 is three minutes.  I'm going to bet it would take a lot longer than three minutes to set up a free service and it would require some debugging.  Time is my most valuable resource here so I'll opt for using what I know.

To deploy:

`git push heroku <branck>`

## File storage

I'll put the files in S3 because I already have that set up.  ActiveStorage should manage keeping the files as private as we want.

## Database Schema
<img width="947" height="790" alt="codepath-erd (1)" src="https://github.com/user-attachments/assets/591d4a62-1f8c-411d-9b0f-9ba21bc92df0" />



