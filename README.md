
# Assignment Setup Instructions

After cloning this repo, change env variable according to the requirement in .env and env-config.js files (mostly replacing IP alone is fine according to machine endpoint IP).



Then execute 


## Run Locally

Clone the project

```bash
  https://github.com/senthil-akshay27/dy-assignment.git
```

Go to the project directory

```bash
  cd dy-assignment
```





## Demo
After cloning this repo, change env variable according to the requirement in .env and env-config.js files (mostly replacing IP alone is fine according to machine endpoint IP).



Then execute to start all required components like indy network, agents, backend and UI servers.

```bash
  ./start.sh
```


Setup components

![App Screenshot](./assignment_screenshot/setup.png)

URL's for portals, port forward 4000,4001,4002 if required.

```bash
  # Verifier Portal 
  http://localhost:4000/

  # Holder Portal 
  http://localhost:4001/

  # Issuer Portal 
  http://localhost:4002/
```
You can replace IP with localhost if required.


## Screenshots

Open user portal with port 4001

![App Screenshot](./assignment_screenshot/1.png)

Click Sign up to register user and to create wallet
use six number pin in password

![App Screenshot](./assignment_screenshot/2.png)

After signup screen will be redirected to login page enter required credential to login.

![App Screenshot](./assignment_screenshot/3.png)

Raise credential request by filling up form.

![App Screenshot](./assignment_screenshot/4.png)

![App Screenshot](./assignment_screenshot/5.png)

Once credential is issued it will be visible in Credential list.

![App Screenshot](./assignment_screenshot/6.png)

To list connections select My Connections tab.

![App Screenshot](./assignment_screenshot/7.png)

Open issuer portal with port 4002

Username: user@example.com  
Password: password

![App Screenshot](./assignment_screenshot/8.png)

We can check credentials issued and list of connections.

![App Screenshot](./assignment_screenshot/9.png)

![App Screenshot](./assignment_screenshot/10.png)

Open veriifer portal with port 4000

Username: user@example.com  
Password: password

![App Screenshot](./assignment_screenshot/11.png)

Select required credential attributes for verification.

![App Screenshot](./assignment_screenshot/12.png)

Select user to send verification request

![App Screenshot](./assignment_screenshot/20.png)

![App Screenshot](./assignment_screenshot/21.png)

Go to user portal and Proof Requests tab

![App Screenshot](./assignment_screenshot/15.png)

Click View and respond and click accept to share data with the verifier after checking the required attributes and conditions.

![App Screenshot](./assignment_screenshot/22.png)

Go back to verifier portal, credential and verification details will be visible in popup. 
"Verified": true (Successfully verified)

![App Screenshot](./assignment_screenshot/23.png)


"Verified": false (Successfully verified)

![App Screenshot](./assignment_screenshot/false.png)

To Stop the setup execute

```bash
  ./stop.sh
```
