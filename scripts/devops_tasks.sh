#!/bin/bash

# Log file path
LOG_FILE="$HOME/devops-automation/logs/devops_automation.log"

# Function to check server uptime
check_uptime() {
    echo "🔹 Checking server uptime..." | tee -a "$LOG_FILE"
    uptime | tee -a "$LOG_FILE"
}

# Function to monitor disk space
check_disk_space() {
    echo "🔹 Checking disk space..." | tee -a "$LOG_FILE"
    df -h | grep "/dev/sda1" | tee -a "$LOG_FILE"
}

# Function to clean old logs
clean_logs() {
    echo "🔹 Cleaning logs older than 7 days..." | tee -a "$LOG_FILE"
    find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
}

# Function to take a MySQL database backup
backup_database() {
    echo "🔹 Taking database backup..." | tee -a "$LOG_FILE"
    mysqldump -u admin -p'YourPassword' your_database > ~/backup/db_backup_$(date +%F).sql
}

# Function to send an alert via Email
send_email_alert() {
    echo "🔹 Sending email alert..." | tee -a "$LOG_FILE"
    echo "DevOps Daily Tasks Completed ✅" | mail -s "DevOps Report" your@email.com
}

# Function to send Slack notification
send_slack_alert() {
    curl -X POST -H 'Content-type: application/json' --data '{"text":"🚀 DevOps Daily Tasks Completed ✅"}' https://hooks.slack.com/services/your/slack/webhook
}

# Execute functions
echo "🚀 Starting DevOps Automation Script - $(date)" | tee -a "$LOG_FILE"
check_uptime
check_disk_space
clean_logs
backup_database
send_email_alert
send_slack_alert
echo "✅ Task Execution Completed - $(date)" | tee -a "$LOG_FILE"
