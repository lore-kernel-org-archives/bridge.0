Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F57E10C
	for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200778; cv=none; b=JZbpsIkTuqGf8tf6kkPoCEkDOke2Z6Lv1ZvMVNlVfiDZvJDv9AWM9NSt3JXZL1z6i0PseUT857Ll0l/cE5/SQ3u+E9SZmqeyhwVaM5RN9lMBENQ7ukBeO1lXM7f4hei2qJka9GInvXNAp99zVmFiBgQiukj7HBagxugOQLZrdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200778; c=relaxed/simple;
	bh=8IktCrsRC+hlS8Myl1fdnPGp6EP8hC9J1haMpC61SOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WB5bJCtmHrcbIVBo1nvVwucBZAGGL+RB2ZJixg57zpiTr+weKedEOcTfmvFyX2ptLOKr7T1IMR3bpoYopnBtShCk8vnMn/kUviRzDgY+uKI6cwk0c1vAB2b4BxLlC65b8oa/P1J3EXs7Yo5qw5Wkn9b4/oa0T13pOgDalIjKgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=PpgtROzV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="PpgtROzV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2846415a12.3
        for <bridge@lists.linux.dev>; Sat, 17 Feb 2024 12:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200776; x=1708805576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/RyA0owvp8Vb/My3RmXXVsAxzzWZv+QMQ3rufBIEHU=;
        b=e7iK2yswhFCrZlOit9pIEyNiWPmR42cIFqyO4u1Wb4VHmGtRZ+e3AcO2D1aLm35nYt
         DUUSh3sVVO4OvURHP3YAIJvGoeE/qFUEXHuYhNg42zT99aqGKbAzt535t1FJM1evTCA8
         W+k2WqtHiwb6ZkwY04FPPLqNUER4Pt1aRhMN3ltDyQKJYEdCfJSB10B7rOn5OguB4fSo
         WXnrrheDkZXyY0m3voF191eUe70AJgv6QT7coSIjMhzgrvlXZKC87TkJ9Jnhp9xl7seg
         LL3wBlfNjjTU94jP2Xz9gduOTmJH/m2O39TKai829/RQ+ghAgn18KdVkXSBA7Kfh0yKs
         Wv4g==
X-Forwarded-Encrypted: i=1; AJvYcCXoyJ/4RtRa9sOHD0OBf0zZI9RNuTKq5PRZ4y82HnX7J1SFlwYbPKVv0BI2XuXYXo5PFKjuNhrMQp9vDrWYygdVJnvCi4d9
X-Gm-Message-State: AOJu0YxK67Pai3ObHYXhgMFfB/5bcUSUhjKZqfuO1wEK96I9zzdGnQlH
	1CceTQfHLqzWfHAz2X+8Ub1g59Ah/XLRbT+44zJc3E3cJSQaGqyU
X-Google-Smtp-Source: AGHT+IFFR+WvQ7e0onQtY4dZ6AcQhZ1Rlt02QSaKR9uAScQLp0C1KkbgTsK80QpcwvYKNme/Donw/A==
X-Received: by 2002:a05:6a00:1822:b0:6e0:3939:60dc with SMTP id y34-20020a056a00182200b006e0393960dcmr10299722pfa.23.1708200775782;
        Sat, 17 Feb 2024 12:12:55 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b006e363ca24dcsm1281725pfn.67.2024.02.17.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:12:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/RyA0owvp8Vb/My3RmXXVsAxzzWZv+QMQ3rufBIEHU=;
	b=PpgtROzVu4fxgbA384MRbpgF+FeUxvP8j69pOojHuzqDCqIqQWZAAotSr6WCDaghpufBWq
	CtcU/JmiMs83KsjNV+6Pc/65LIZYHZXMmu3coO35DMVT/Xfhn8/qAJ18pq1f7OS6J14WIy
	RJj41euKpj9DjqAjPwn/iGhlI4c2ITpRFw3obJnCCAI5C1hxFMYVGFhZx2Lll2HsFiiffd
	PIOYWf08hcY7hCciMc4vKtBzJPdq9TyrBZjCo54PbUwAKxiTLLURggX58EPJPO6eeByLzT
	+WlALkmmx9l1mDlB/SxmRZto8d1GKF57eNnkfcU0QASkZ6I7u81GBsT8nNZheA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 00/12] net: constify struct device_type usage
Date: Sat, 17 Feb 2024 17:13:22 -0300
Message-Id: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMT0WUC/x2MWwqAIBAAryL7naDSQ7tKRIhttRAWWhGId0/6H
 JiZBBEDYYSeJQj4UKTDF5AVA7dZvyKnuTAooWqhZMfnIjmc3I7W3yf3eHHdadMK00jTaijhGXC
 h958OY84fnVJAZGQAAAA=
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=8IktCrsRC+hlS8Myl1fdnPGp6EP8hC9J1haMpC61SOg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNrpk7BX+VmqEEeJxcyIwSF9ZeHvTQLW5p1V
 ealPQCKRLOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETawAKCRDJC4p8Y4ZY
 plYsD/wLcDBrNqH7PMKSjPkDtyu9739Mvkq+1uT348a8e82LOWBnOdKK6q+DkjgyUHodP2kqFyB
 q+OBZevG9xCq7m5Nbu5mjwu6pALcRTrny9S5Zk0cLWMSZAIXYTvexzFW5CLi4XUHeqR3Qwq8c+U
 GetCdNHd/HNgOyqW/L9kd5s1ivpxGffSeBzNg3WhrWajErwBAHboUc1HJ17FD8tPSTcPAvUwl97
 Wl0auf0nme1Niz+WyayZv9iRtZut21l+tVeMH+HqWYjh36SKvkrU/p2hPzR8syuDHLvk+j0T2q2
 IVg4PE18HskT1IoRQ5s+9D85b5zqVuU7e2k/eRrxkMJVG08tcmnxOYZ0eKzYEBQMrXECyqlS4ty
 It1ohBySWA58CT7b0XC4jduQ1APoExAel6JvYgMVP0U/IQ+1dRGVX7o6mRjpj9vdGlXisYNIya6
 RnkAPo4SFGuLWYUSta0O1rRUbVzh9ZkOs1A3usrujPywEvrT7ylTOwEpnlr2FL8RAZn9udVV08m
 MA99oSDSBPqtqIWk7/Z5cdlaOBZwEmytINyYUaX4CV5SHFWtO7K3wjojXMityKLq3iabpjm10z9
 ZdzdzWwgoD1HhvD8cAUC1WCU/j/owgoaFbXHZaDAaKrEhWTlTpKlw0t3s4AdKkMWmyU+iYreHuV
 MtNhqyvaf91HA/g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that makes all device
types in the net subsystem constants. This has been possible since 2011 [1]
but not all occurrences were cleaned. I have been sweeping the tree to fix
them all.

I was not sure if I should send these squashed, but there are quite a few
changes so I decided to send them separately. Please let me know if that is
not desirable.

---
[1] https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (12):
      net: usbnet: constify the struct device_type usage
      net: dsa: constify the struct device_type usage
      net: bridge: constify the struct device_type usage
      net: vxlan: constify the struct device_type usage
      net: ppp: constify the struct device_type usage
      net: geneve: constify the struct device_type usage
      net: hsr: constify the struct device_type usage
      net: l2tp: constify the struct device_type usage
      net: vlan: constify the struct device_type usage
      net: netdevsim: constify the struct device_type usage
      net: wwan: core: constify the struct device_type usage
      net: hso: constify the struct device_type usage

 drivers/net/geneve.c           | 2 +-
 drivers/net/netdevsim/bus.c    | 2 +-
 drivers/net/ppp/ppp_generic.c  | 2 +-
 drivers/net/usb/hso.c          | 2 +-
 drivers/net/usb/usbnet.c       | 4 ++--
 drivers/net/vxlan/vxlan_core.c | 2 +-
 drivers/net/wwan/wwan_core.c   | 2 +-
 net/8021q/vlan_dev.c           | 2 +-
 net/bridge/br_device.c         | 2 +-
 net/dsa/user.c                 | 2 +-
 net/hsr/hsr_device.c           | 2 +-
 net/l2tp/l2tp_eth.c            | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
change-id: 20240217-device_cleanup-net-878960951968

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>

