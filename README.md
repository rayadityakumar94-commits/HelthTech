# HelthTech
<div align="center">

[![HIPAA Compliant](https://img.shields.io/badge/HIPAA-Compliant-green?style=flat-square)](https://www.hhs.gov/hipaa)
[![React](https://img.shields.io/badge/React-18-61DAFB?style=flat-square&logo=react)](https://react.dev)
[![Node.js](https://img.shields.io/badge/Node.js-24-339933?style=flat-square&logo=node.js)](https://nodejs.org)
[![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3-38B2AC?style=flat-square&logo=tailwind-css)](https://tailwindcss.com)

**HealthTech is an AI-powered platform that automatically removes sensitive patient information from clinical documents — ensuring HIPAA compliance before any data reaches an external AI model.**

</div>

---

## 📌 What is This Project?

When doctors send patient consultation notes, lab reports, or audio recordings to AI tools like ChatGPT, those documents contain highly sensitive information such as **patient names, Social Security Numbers, phone numbers, and dates of birth**.

This information is protected under **HIPAA law** — sending it to an external AI API without proper de-identification is **illegal** and can result in fines ranging from **$100,000 to $1.9 million**.

**HealthTech solves this problem.**

The platform acts as a secure proxy pipeline:
1. A doctor uploads their clinical document
2. The AI engine scans for all 18 HIPAA Safe Harbor identifiers
3. Sensitive data is replaced with pseudonyms or redaction markers
4. The cleaned document is safe to send to any AI — **no real patient data ever leaves the organization**

---

## 🔄 How the Platform Works — Step by Step

### Step 1 — Doctor Logs In
- The doctor enters their email and password
- The system generates a **JWT token** to create a secure session
- The user's role is verified — Doctor, Admin, or Compliance Officer

### Step 2 — Document Upload
- The doctor uploads a clinical file by dragging it or clicking to browse
- Supported formats: **PDF, DOCX, TXT, MP3, WAV, M4A**
- The file is securely saved on the server
- A real-time upload progress bar is displayed

### Step 3 — AI Redaction Engine Runs
- The platform reads the document text
- All **18 HIPAA Safe Harbor PHI identifiers** are detected and replaced:
  - Patient names → `[NAME_1]`
  - Date of birth → `[DATE_1]`
  - Social Security Number → `[SSN_1]`
  - Phone numbers → `[PHONE_1]`
  - Email addresses → `[EMAIL_1]`
  - Home address → `[ADDRESS_1]`
  - Medical Record Number → `[MRN_1]`
  - Provider NPI number → `[NPI_1]`
  - IP addresses, URLs, and 10 more types...
- Each detection shows a **confidence score** (94–100%)
- Original and redacted text are displayed side by side

### Step 4 — Download and Export
- The doctor can **download the redacted document**
- The compliance officer can download a **PDF compliance report**
- Reports can also be exported as **Excel/CSV**
- Every action is logged in a complete **audit trail**

### Step 5 — AI Chat Assistant
- The doctor can ask the **AI assistant** questions about the redacted document
- The AI only uses safe, redacted data — no PHI is ever transmitted
- Diagnoses, medications, and summaries are all available safely

---

## 🖥️ Every Page and What It Does

### 🌐 Landing Page (`/`)
- Public page — no login required
- Showcases platform features and capabilities
- Displays statistics: 2.4M+ documents processed, 99.9% accuracy
- Includes testimonials and a "Get Started" call-to-action
- Fully responsive with dark mode support

### 🔐 Login Page (`/login`)
- Secure login using email and password
- "Remember me" option for persistent sessions
- "Forgot Password" link for account recovery
- Demo credentials are displayed for testing
- Automatically redirects to the dashboard on success

### 📝 Signup Page (`/signup`)
- **2-step registration process:**
  - Step 1: Full name, email, organization name, and role
  - Step 2: Set password with a live strength indicator
- Role selection: Doctor / Compliance Officer / Admin / Nurse
- Redirects to the email verification page after account creation

### 🔑 Forgot Password Page (`/forgot-password`)
- Enter your registered email address
- A password reset link is sent
- Displays a confirmation screen after submission

### ✅ Email Verification Page (`/verify-email`)
- Shown after account registration
- Instructs the user to check their inbox and click the verification link

### 📊 Dashboard (`/dashboard`)
**The main control panel — everything is managed from here**

- **4 Stat Cards** — Total documents redacted, PHI identifiers found, files uploaded today, compliance score
- **Area Chart** — Daily breakdown of files uploaded vs. redacted for the current week
- **Bar Chart** — Monthly PHI identifier count for the last 6 months
- **Pie Chart** — Distribution of PHI types (names, dates, SSNs, etc.)
- **Recent Documents Table** — Latest uploaded files with status badges
- **Quick Action Buttons** — Direct access to Upload, Redaction, Chat, and Activity

### 📤 Upload Page (`/dashboard/upload`)
- **Drag & Drop zone** — drop files directly onto the page
- Or click to browse and select files from your computer
- Multiple files can be uploaded simultaneously
- **Supported formats:** PDF, DOCX, TXT, MP3, WAV, M4A
- **Maximum size:** 50MB per file
- Real-time **progress bar** for each file
- Each file shows its name, size, and upload status (Ready / Uploading / Success / Failed)

### 🤖 AI Redaction Page (`/dashboard/redaction`)
**The core feature of the platform**

- Paste any clinical text into the **text box**
- Choose one of **3 Redaction Modes:**
  - **Pseudonym Mode** — `John Smith` → `[NAME_1]` *(default)*
  - **Black Redaction** — `John Smith` → `████████████`
  - **Category Labels** — `John Smith` → `[NAME]`
- Click **"Run AI Redaction"** to start processing
- A progress bar shows real-time processing status
- **Left panel:** Original text
- **Right panel:** Redacted output (highlighted in green)
- **PHI Detection Panel** shows every detected identifier:
  - Type (Patient Name, SSN, Date, etc.)
  - Original value (shown in red)
  - Replacement value (shown in green)
  - Confidence percentage
- **Download button** — save the redacted text as a file
- **Copy button** — copy redacted text to clipboard

### 💬 AI Chat Page (`/dashboard/chat`)
**HIPAA-safe AI assistant for clinical document analysis**

- A **chat interface** similar to ChatGPT
- Doctors can ask questions about their redacted document
- **Suggested Prompts** are available in the sidebar (pre-written clinical queries)
- The AI operates in **PHI-Safe Mode** — no patient data is ever processed
- Message layout:
  - Doctor's message — right side, blue bubble
  - AI response — left side, white bubble
- A **typing indicator** is shown while the AI is generating a response
- **Copy button** on every message
- **Clear Chat** button to start a new session
- **Privacy Status Panel** — shows real-time confirmation that PHI detection is active

### 👨‍⚕️ Profile Page (`/dashboard/profile`)
**Three tabs for managing your account:**

**Tab 1 — Personal Information:**
- Update name, email, organization, medical specialty
- Edit phone number, role, and professional bio
- Profile stats displayed: documents processed, PHI redacted, compliance rate, days active

**Tab 2 — Security:**
- Change current and new password
- Enable or disable **Two-Factor Authentication (2FA)**

**Tab 3 — Notification Preferences:**
- Toggle switch for each notification type
- Options: Redaction complete, PHI alert, upload success, weekly report, system updates, security alerts

### 📅 Activity Timeline (`/dashboard/activity`)
**Complete audit trail of all platform actions**

Every action is logged, including:
- ✅ Document redacted
- 📤 File uploaded
- ⚠️ High PHI density alert
- 📥 Report downloaded
- 💬 AI chat session started
- 👤 User login
- ❌ Upload failed

Features:
- **Filter buttons** — All / Upload / Redaction / Download / AI / Alert / User
- **Search bar** — find any specific activity
- Timeline grouped by date
- Each entry shows: title, description, timestamp, username, and status badge

### 📊 Reports Page (`/dashboard/reports`)
**Generate and download compliance reports**

- **Summary Stats:** Total documents, PHI removed, compliance rate, estimated time saved
- **Monthly Bar Chart** — documents processed per month
- **Line Chart** — PHI detected vs. compliant documents trend over time
- **4 Report Types** — each with a download button:
  - Compliance Summary Report
  - Redaction Activity Report
  - PHI Detection Report
  - Full Audit Trail
- **3 Export Formats** — PDF / CSV / XLSX

### 👥 Admin Panel (`/dashboard/admin`)
**Accessible only to users with the Admin role**

- **User Stats Cards** — total users, active users, admins, total documents
- **User Management Table:**
  - Displays each user's name, email, role, organization, document count, and last login
  - **Activate / Deactivate** button per user
  - **Edit** button per user
  - **Delete** button per user
- **Search bar** — find users by name or email
- **Invite User** button
- **System Configuration Panel:**
  - AI Model Version
  - HIPAA Mode setting
  - Audit retention period
  - Maximum file size limit

### 🔔 Notification Bell (in the Header)
- Click the bell icon in the top navigation bar
- A **notification panel** slides out from the right
- An unread count badge (red dot) is shown on the bell icon
- Notification types include:
  - Redaction complete
  - Upload success
  - High PHI density alert
  - System updates
- "Mark all read" button
- "View All Notifications" button

### 🔍 Global Search (in the Header)
- Click the search bar in the header or press **⌘K** / **Ctrl+K**
- A **Search Modal** opens as an overlay
- Recent searches are displayed by default
- Start typing to see real-time document results
- Quick links for Upload, Chat, and Profile
- Press **ESC** or click outside to close

### 🌙 Dark Mode (in the Header)
- Click the sun/moon icon in the top navigation bar
- The entire website switches to **dark theme**
- The preference is saved in **localStorage** — it persists even after closing the browser

---

## 👥 Who Uses HealthTech — User Roles

### 🩺 Doctor / Clinical User
**Can do the following:**
- Upload clinical documents
- Run AI redaction on text or files
- Download redacted documents
- Use the AI chat to analyze redacted content
- Manage their own profile and settings
- View their personal activity timeline

### 🛡️ Compliance Officer
**Everything a doctor can do, plus:**
- Access and download all compliance reports
- View the full team activity timeline
- Verify audit trails for regulatory purposes

### ⚙️ Administrator
**Full access, including:**
- Manage all users (add, edit, delete, activate/deactivate)
- Assign and change user roles
- Configure system settings
- Update AI model version and HIPAA policy settings

---

## 🔒 How Security Works

| Feature | What It Does |
|---|---|
| **JWT Token** | A signed token is generated at login and sent with every request to verify identity |
| **bcrypt** | Passwords are hashed before storage — the original password is never saved |
| **Rate Limiting** | Max 100 requests per 15 minutes to prevent brute force attacks |
| **Helmet.js** | Sets secure HTTP response headers |
| **CORS Protection** | Only requests from allowed origins are accepted |
| **Role Guards** | The admin panel is protected at the route level — only admins can access it |
| **Input Validation** | All user inputs are validated on the server side |

---

## 🚀 How to Run the Project

### Option 1 — One Command (PowerShell):
```powershell
.\run.ps1
```

### Option 2 — Two Terminals Manually:
```bash
# Terminal 1 — Backend
cd backend
node server.js

# Terminal 2 — Frontend
cd frontend
npm run dev
```

Then open **`http://localhost:3000`** in your browser.

### Demo Login Credentials:
| Role | Email | Password |
|---|---|---|
| 🩺 Doctor | `doctor@health.com` | `password` |
| ⚙️ Admin | `admin@health.com` | `password` |

---

## 📁 Project Folder Structure

```
HealthTech – Automated/
│
├── frontend/                  ← React web application
│   └── src/
│       ├── pages/             ← All page components (Login, Dashboard, etc.)
│       ├── components/        ← Reusable UI parts (Sidebar, Notifications, Search)
│       └── context/           ← Global state for Auth and Theme
│
├── backend/                   ← Node.js Express API server
│   ├── routes/                ← All API route handlers
│   ├── middleware/            ← JWT authentication middleware
│   └── server.js              ← Main server entry point
│
├── run.ps1                    ← PowerShell one-click launcher
├── start.bat                  ← Windows batch file launcher
├── stop.bat                   ← Stops all running servers
└── PRESENTATION.html          ← Project presentation slides (10 slides)
```

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Frontend | React 18 | UI framework |
| Frontend | Vite | Fast build tool and dev server |
| Frontend | TailwindCSS | Utility-first CSS styling |
| Frontend | React Router v6 | Client-side navigation |
| Frontend | Recharts | Charts and data visualization |
| Frontend | React Dropzone | Drag and drop file uploads |
| Frontend | Axios | HTTP requests to the backend |
| Frontend | Framer Motion | Animations and transitions |
| Backend | Node.js + Express | REST API server |
| Backend | JWT | Secure authentication tokens |
| Backend | bcryptjs | Password hashing |
| Backend | Multer | File upload handling |
| Backend | Mongoose | MongoDB database ORM |
| Backend | Helmet | HTTP security headers |
| Backend | Express Rate Limit | API abuse prevention |

---

## 📊 Project Statistics

| Metric | Value |
|---|---|
| Total Pages | 14 |
| API Endpoints | 15+ |
| PHI Types Detected | 18 |
| Supported File Formats | 6 |
| Redaction Accuracy | 99.8% |
| Average Processing Time | 2.3 seconds |
| Total Features Built | 22+ |

---

<div align="center">

**Built with React + Node.js + TailwindCSS**

*Project 2 — HealthTech Internship | AI-Powered HIPAA Compliance Platform*

⭐ Star this repository if you found it helpful!

</div>
