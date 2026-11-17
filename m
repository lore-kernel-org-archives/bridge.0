Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.124.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934284;
	b=TUlmm8b097vyQnICp8GP5Oj/3ornyeXV52Epz2VWqtdYk/3QYWmz0Y47Eo5dXI8qX2qT
	 svnENII4Tkv4WJIUZAIYodhgEldmu94QUO5sulvCWGdMD61ynz8S0mxzwHO5VTcJcOV42
	 q2QcVlb0vVGCfSbMTkBgLXxjXMjyt9LPB/WwZQI2q+7XhPiMgzsriAkyzT5YauKCbKhZh
	 SmxHmCnPgm53zL+VbQ8gWPWhKZIhe4ghg68UBo7MJQQG8QU1OV4JFfBw534riWjSQGDkm
	 BCIsZQDN3U83nzKEVXb+5ycYuEYAkNdDzr6PkVJT4rltPI5P0hj/lf62C97QIpZq8Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934284;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xnTlG3RhB5eZYXoKfh+lrOl3/6yxxp2X5UnqYVp1GAI=;
	b=o91tDrfUwj6hXU8HpquZ4NVyMoVwGma3i2cWGDiCtce10rTPm4rzYCoOL0IHlkydx4HH
	 QCK17aAK6+Tlf1N03JkGq6BSBHPMxWGflXNErq7DBNNA/7kWphmFegD++kGrt2htLZjcm
	 KmB/j2tWbaMFC8CM1Y5wMQ8Pj56mPNCstBtQ5pm5ulBaSv9K8hNlYvdpZ8khPTRh+RFwq
	 MhXY+FLf161Sc0IhxOTQZZnYd+zIGgV0GZurNQ8RUGFP9L51I2fAiqtczzBgVfufMdKSW
	 fsqbkUj3oHUTGLrPLGtYdI7Oz1x9rQqbxUJgpuGA4RfYERGOVdTJ/JbES0HeIhWUVCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=fu1HXOF+;
	arc=none smtp.remote-ip=51.250.124.96
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [51.250.124.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5A606A338
	for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 16:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C5A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=fu1HXOF+
Received: from mail-nwsmtp-smtp-production-main-73 (mail-nwsmtp-smtp-production-main-73.yp-c.yandex.net)
	by forward100a.mail.yandex.net (postfix) with ESMTPS id 9AFA4C03DB;
	Tue, 17 Nov 2026 19:51:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73 with ESMTPSA id 8pcmEQ0mua60-7s8HV7bS;
	Tue, 17 Nov 2026 19:51:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1794934271; bh=xnTlG3RhB5eZYXoKfh+lrOl3/6yxxp2X5UnqYVp1GAI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fu1HXOF+WB8tkBLAnYa//UwM5+WLJ7+kyPMhRJDTBmzbWDFWRa318TfGZYc9Pwvor
	 +VpIa2E8pqV169upH6lcMNGupesUsDe5SiPx155LR4Uk4NNPtjzLhxN4vaqy8Y6V8m
	 g38YFsyJZYT7jizbyBH4+J/joWfh5XP/txKSJCQ8=
Authentication-Results: mail-nwsmtp-smtp-production-main-73; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: bridge: avoid redundant strlen() in show_backup_port()
Date: Tue, 17 Nov 2026 19:51:06 +0300
Message-ID: <20261117165106.635733-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In store_backup_port(), prefer strchrnul() over strchr() to
avoid redundant call to strlen().

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bridge/br_sysfs_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 621d62a063d9..03205b3f465f 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -231,12 +231,12 @@ static ssize_t show_backup_port(struct net_bridge_port *p, char *buf)
 static int store_backup_port(struct net_bridge_port *p, char *buf)
 {
 	struct net_device *backup_dev = NULL;
-	char *nl = strchr(buf, '\n');
+	char *nl = strchrnul(buf, '\n');
 
-	if (nl)
+	if (*nl != '\0')
 		*nl = '\0';
 
-	if (strlen(buf) > 0) {
+	if (nl - buf > 0) {
 		backup_dev = __dev_get_by_name(dev_net(p->dev), buf);
 		if (!backup_dev)
 			return -ENOENT;
-- 
2.56.1

