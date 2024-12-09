#!/usr/bin/env python3

import feedparser
import smtplib
import os
import requests
import re
from email.header import Header
from email.mime.text import MIMEText

# RSS源
RSS_URL = 'https://distrowatch.com/news/dwd.xml'

# 邮箱配置
FROM_EMAIL = os.getenv('FROM_EMAIL')
TO_EMAIL = os.getenv('TO_EMAIL')
SMTP_SERVER = 'smtp.qq.com'
SMTP_PORT = 587
SMTP_USERNAME = os.getenv('SMTP_USERNAME')
SMTP_PASSWORD = os.getenv('SMTP_PASSWORD')

# 上次更新
LAST_UPDATES = os.getenv('LAST_UPDATES')

# github token
TOKEN = os.getenv('TOKEN')

# 监视的发行版
WATCHED_DISTROS = os.getenv('WATCHED_DISTROS').splitlines()


def checkUpdates():
    feed = feedparser.parse(RSS_URL)
    new_updates = {entry['title'] for entry in feed.entries}

    updates = sorted(new_updates - set(LAST_UPDATES.splitlines()))

    watched_updates = [distro for distro in updates for watched_distro in WATCHED_DISTROS if re.search(watched_distro, distro)]

    if updates:
        print("更新内容：\n" + '\n'.join(updates) + '\n')
        updateLastUpdates(new_updates)
        if watched_updates:
            print("监视的发行版有更新：\n" + '\n'.join(watched_updates) + '\n')
            sendEmail(watched_updates)
        else:
            print("监视的发行版无更新")
    else:
        print("无更新")


def updateLastUpdates(updates):
    url = "https://api.github.com/repos/Alex6357/compatmgr/actions/variables/LAST_UPDATES"
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer {}".format(TOKEN),
        "X-GitHub-Api-Version": "2022-11-28"
    }
    data = {
        "name": "LAST_UPDATES",
        "value": "{}".format('\n'.join(updates))
    }
    requests.patch(url, headers=headers, json=data)


def sendEmail(updates):
    message = MIMEText('\n'.join(updates), 'plain', 'utf-8')
    message['From'] = Header(FROM_EMAIL)
    message['To'] = Header(TO_EMAIL)
    message['Subject'] = Header('Github Actions: DistroWatch Updates', 'utf-8')
    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(SMTP_USERNAME, SMTP_PASSWORD)
        server.sendmail(FROM_EMAIL, [TO_EMAIL], message.as_string())
        server.quit()
        print('邮件发送成功')
    except smtplib.SMTPException as e:
        print('邮件发送失败', e)


def main():
    checkUpdates()


if __name__ == '__main__':
    main()
