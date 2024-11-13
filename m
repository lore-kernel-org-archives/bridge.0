Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C91DFE00
	for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502667; cv=none; b=LNv61pgjvRELjhj7PgJ39ZOLNwIDhoKP/xfPEKe9U/CzzUG1WIFj7jxQn7WBNT9RXRXbG2hm1Z8wTzHJkUIVcMExvugd/XXhkq7Xln38HXrvbEuIO8UygBqgaje3PIZbRZ42G7L13bEcd/bk5Pu09eanFyhgEaHRXlJGXpwztkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502667; c=relaxed/simple;
	bh=Z9LWtAm1B8O3T0XTKvOdS5SDy0kIbhN/IsSC65Nbxck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgufzkDUhGSjjHSYj/mbO96yDLoksKX1bzBk8rr26pESpxXkZ1ZjBQGmwhaVFJ3jQ8Cd9zY08V0VeSi5uOIUmlgCJowAYTd+idDp/nCD0IWrVMjE/u6kUDtwjFb15EVHl+V6BdkzPxFQTMokPvVeEhBns/fv/1x0dtydOrNmXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5u9QC1M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5u9QC1M"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e31af47681so5514816a91.2
        for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502665; x=1732107465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
        b=N5u9QC1M00I0CluNxTMDUp7qjzftwMBJ9NEIpXcjQvFO7wRBTtZKXtYqH2FYHA76N8
         C7wSfu74nfRndbFvH9ZPXYrforj+4T0CHBchkJMWu+r7Dt4hmUEKirKdhpx2SzDWdJRd
         H3lzOLFzgbA6isKXlgHoOseaw576B8/0EbkkUu3PuBndP3tOVLr1NoP+YY/6NyuTGf3p
         jkmehlFlOC7dITjAnN5pDzIX+Vj/ukIa4LDodj7sfJpttEIACMFi60HjwPibW4hhp6TW
         6X97+jcqU+bNBsDiYHd5pQ/IRfYc21oW27FBbr7OzTouG4glMorOVbN9DjfxfAMoN6HT
         eCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502665; x=1732107465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
        b=lEWbgQr6MGnbMsgTpEKXnTFTgdw3BZCm43NJeHVmjFcjolYT/hgTQgp/zY4cyHCL0m
         73wuYuczLvIPmqtG6vGkQnsqCloHVpIwTDcsYiFWMrrFWPIvnv3GspjLwNMkbT3tQlUK
         cF25oWDBKa4oz6MQhTYDgmubeI4JCDkXi/+U9iGCgKKsW5jCHSGFT6TYdXxpMIhu0ylQ
         15xlgBD9pVW9by6/4Wj4puBdkX4fM5+UndShb+Y3e0OlKc/cvKNuu6b9QPqdgNr80BQl
         /DXV/JTDT3dZe2GsXs3EgnARVWDnzQ3TIHPk0Nxd8p/aVhXNbhi+LrbOqO5qniAWTk5i
         1Fpw==
X-Forwarded-Encrypted: i=1; AJvYcCVO+g6Rxa3ZXJN4hLVfMA5SNMoefGOWnYkhVyzEj+XyOa7b7lV7+bF55uaGZHzz+o0MItaZjQU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3b5QksqGYc6BYoISA8e3Bu0AuvCBlTF0n1wOxDuvKy1gscpYl
	3RhODiYD7RddcobHfrjfI4RkBipikNLQndU9FKZaPEvySCvbEHdU
X-Google-Smtp-Source: AGHT+IFBBLW/otzoU3VQWNkQ98rdfNz5WHNkXJFNuYVXzuqAWCzWf4F656wLCdVO3Ph+9deaw1I3JA==
X-Received: by 2002:a17:90b:48c8:b0:2e2:c40c:6e8a with SMTP id 98e67ed59e1d1-2e9f2d5da7amr2684315a91.26.1731502664731;
        Wed, 13 Nov 2024 04:57:44 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:44 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/6] Revert "tools/net/ynl: improve async notification handling"
Date: Wed, 13 Nov 2024 20:57:10 +0800
Message-ID: <20241113125715.150201-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donald Hunter <donald.hunter@gmail.com>

This reverts commit 1bf70e6c3a5346966c25e0a1ff492945b25d3f80.

This modification to check_ntf() is being reverted so that its behaviour
remains equivalent to ynl_ntf_check() in the C YNL. Instead a new
poll_ntf() will be added in a separate patch.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 10 +++-----
 tools/net/ynl/lib/ynl.py | 49 ++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 9e95016b85b3..b8481f401376 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -5,7 +5,6 @@ import argparse
 import json
 import pprint
 import time
-import signal
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -18,8 +17,6 @@ class YnlEncoder(json.JSONEncoder):
             return list(obj)
         return json.JSONEncoder.default(self, obj)
 
-def handle_timeout(sig, frame):
-    exit(0)
 
 def main():
     description = """
@@ -84,8 +81,7 @@ def main():
         ynl.ntf_subscribe(args.ntf)
 
     if args.sleep:
-        signal.signal(signal.SIGALRM, handle_timeout)
-        signal.alarm(args.sleep)
+        time.sleep(args.sleep)
 
     if args.list_ops:
         for op_name, op in ynl.ops.items():
@@ -110,8 +106,8 @@ def main():
         exit(1)
 
     if args.ntf:
-        for msg in ynl.check_ntf():
-            output(msg)
+        ynl.check_ntf()
+        output(ynl.async_msg_queue)
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92f85698c50e..c22c22bf2cb7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -12,8 +12,6 @@ import sys
 import yaml
 import ipaddress
 import uuid
-import queue
-import time
 
 from .nlspec import SpecFamily
 
@@ -491,7 +489,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
-        self.async_msg_queue = queue.Queue()
+        self.async_msg_queue = []
 
         for msg in self.msgs.values():
             if msg.is_async:
@@ -905,39 +903,32 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.put(msg)
+        self.async_msg_queue.append(msg)
 
-    def check_ntf(self, interval=0.1):
+    def check_ntf(self):
         while True:
             try:
                 reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
-                nms = NlMsgs(reply)
-                self._recv_dbg_print(reply, nms)
-                for nl_msg in nms:
-                    if nl_msg.error:
-                        print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
-                        print(nl_msg)
-                        continue
-                    if nl_msg.done:
-                        print("Netlink done while checking for ntf!?")
-                        continue
+            except BlockingIOError:
+                return
 
-                    decoded = self.nlproto.decode(self, nl_msg, None)
-                    if decoded.cmd() not in self.async_msg_ids:
-                        print("Unexpected msg id while checking for ntf", decoded)
-                        continue
+            nms = NlMsgs(reply)
+            self._recv_dbg_print(reply, nms)
+            for nl_msg in nms:
+                if nl_msg.error:
+                    print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
+                    print(nl_msg)
+                    continue
+                if nl_msg.done:
+                    print("Netlink done while checking for ntf!?")
+                    continue
 
-                    self.handle_ntf(decoded)
-            except BlockingIOError:
-                pass
+                decoded = self.nlproto.decode(self, nl_msg, None)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
+                    continue
 
-            try:
-                yield self.async_msg_queue.get_nowait()
-            except queue.Empty:
-                try:
-                    time.sleep(interval)
-                except KeyboardInterrupt:
-                    return
+                self.handle_ntf(decoded)
 
     def operation_do_attributes(self, name):
       """
-- 
2.47.0

