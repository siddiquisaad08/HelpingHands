# 🙌 Helping Hands: A Goods Donation Website

**Helping Hands** is a full-stack web application that enables individuals to donate goods and allows NGOs to request and manage those donations efficiently. It ensures a seamless connection between donors and trusted organizations, promoting transparency and impact in social giving.

---

## 🔗 Repository

GitHub: [https://github.com/siddiquisaad08/HelpingHands](https://github.com/siddiquisaad08/HelpingHands)

---

## 🧰 Tech Stack

| Layer         | Technology               |
|---------------|---------------------------|
| Frontend      | React.js, Bootstrap       |
| Backend       | Node.js, Express.js       |
| Database      | MySQL (managed via MySQL Workbench) |
| Authentication| JWT                       |
| Media Storage | Local (via `/uploads`)    |

---

## 📁 Project Structure

HelpingHands/
├── sevaX-frontend/ # Frontend (React)
│ ├── public/
│ └── src/
│ └── components/
│ └── pages/
│ └── App.js
├── sevaX-server/ # Backend (Node.js + Express)
│ ├── config/ # DB connection
│ ├── controllers/ # Request logic
│ ├── middleware/ # Auth middleware
│ ├── routes/ # Express routes
│ ├── db/ # SQL schema files
│ ├── uploads/ # Image storage
│ └── index.js # Entry point

yaml
Copy
Edit

---

## 🚀 Getting Started

### 🖥️ Frontend Setup

1. **Clone frontend**
   ```bash
   git clone https://github.com/siddiquisaad08/HelpingHands.git
   cd HelpingHands/sevaX-frontend
   npm install
Start frontend

bash
Copy
Edit
npm start
🔧 Backend Setup
Navigate to backend

bash
Copy
Edit
cd ../sevaX-server
npm install
Create MySQL database

Name it seva_x

Import .sql file from db/ directory using MySQL Workbench

Create .env file

env
Copy
Edit
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=seva_x
JWT_SECRET=your_jwt_secret
Run backend

bash
Copy
Edit
npm run dev
✨ Features
🔐 JWT-secured login and registration

👥 Donor and NGO user roles with custom dashboards

🎁 Donation listing and image upload

📩 Request system for NGOs

🧾 Admin panel for moderation and approvals

📱 Fully responsive design

🧪 Testing
Backend tested via Postman

Manual functional testing for user flows

🙋 Contributing
Fork this repository

Create your feature branch (git checkout -b feature/new-feature)

Commit your changes

Push to your branch (git push origin feature/new-feature)

Create a pull request

