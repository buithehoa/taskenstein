# README

<p>
  <h2>Taskenstein</h2>
  <p>Take-home assignment for a Software Engineering role at NetEngine.</p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project
Each task has the following properties
- Title
- Sub-title
- Due date
- Priority

If a task is "completed" by clicking on the checkbox to the left of the task then it can be removed from the list.

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running, follow these steps.

### Prerequisites

[Docker 24](https://docs.docker.com/get-docker/)
<br/>
[Docker Compose 1.29](https://docs.docker.com/compose/install/)

### Installation

1. Clone the repo
   ```sh
   git clone git@github.com:buithehoa/taskenstein.git
   ```
2. Build and run Docker containers by navigating to the project's root directory and executing
   ```sh
   docker-compose up --build
   ```
3. Verify if Rails app is running by visiting http://localhost:3000 in your web browser.

## Testing
To run all specs, create test database and execute `rspec`
```
$ bin/rails db:create RAILS_ENV=test

$ bundle exec rspec
Finished in 1.13 seconds (files took 0.14603 seconds to load)
24 examples, 0 failures
```