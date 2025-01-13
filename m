Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1359284A49
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779148; cv=none; b=u4mNQ8OzhLe51LqA630K2smreLuNpZZq1cUPPkiUQhND1SHR13c66VYC9sPTlWsVH6hYlIWFl4/1f8FGibVCTG7+n7YH5WhGHXDEhUuILXUDzm9FxwO4ytEMBz/xIcabTsZ5hgJ7MXsHKo0/FLEcFLU8bZSWn3ihOqlZiwBUY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779148; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv94hgAK/if3JQI5ycDzxt2/C4G4Lhy9t2+Ou8ypaaXQs1OOeuE8BdeddMH21XS5ocJcmTEKQ4s/dpHSlVRN2m6+fyqMBdIfUSr2Kae1UPs03LgdiWodtOHbfYAqpHu3xGkYZnkInH8ejOJycmnUQrn1kuGNPHSMCXXA7ijkzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWgYqJFu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWgYqJFu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21bc1512a63so12634095ad.1
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779144; x=1737383944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=fWgYqJFuMON+69MICh+I37nXpflFTyvFyMKwRqlGudNavQzNB7N2PV4BzGB1a0SxEU
         KhCML2hdbP4/6FJGoh09ZYS/DPxYBSeUQDkSYkIlqpTPhfh88Tkz2H6L5+/rhe9DMhkf
         StvfoV5U0us5cMGAXZ4tyUQNujv1cUDhPlwWRbLDdnmuCy3FyQaaZAskpRbE3konoznx
         p4jCRLsuSaA3+1svshcBoTJBay8SUS6RgqJhFwzgH4dU7iCku4pMyGtwLgnaa1xr7Fm4
         RS5ekYBX7yk9LfG1jUJm2rZqZBl5W0zytoN3RFBtrdfMlCDaXsl39RbHV8aWFh4UQ5vQ
         /CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779144; x=1737383944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=YAZ4Z36RTyqoh5u3hmsqN2sexpXS4Ke7vhM7g0LNAkWYdbCpNBVsuS6gNoWLk9xwgw
         NfgdlbP7/tG5ltCOi/283k+D58inKHeoE9nL/mbMUuntm6SPecqdxjUD/wG5zA5B8lYN
         cgb8Gi/wLgUul8XBDxp7ff6+A7sLaNG7OLt5KvynIA1KaGeLhrNr9iq01g0pVCdhKXfT
         HgOgU5m0MSJU9onVuz5mN03KVebTCEwxqFG1vY5W1ffRzHeE3MTVra0yyUNC+8BESBQN
         CP3JHLr0rrxGkwPNnwqhqKGPqdSeWfqxVL11WNpXtG3g5LqIVnXVTn22cOhVViP6j9bI
         8HJg==
X-Forwarded-Encrypted: i=1; AJvYcCUeTt1Hpvi6QyhjzLecwcF0TBIAytzWS2B/99jqTUuD/am2tdFnGKpn4osNEWhf+izSXpVBQuI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiJsyurS8i0YdvCNWrKUyTUrYX/EbO+3UCDvOWLbG2X0mvGhgw
	9p91qDOvFGTsQUcJqlULg2UZ5WEqGalEdoRWgSz4mQ01ltWYwFBL
X-Gm-Gg: ASbGnct0goDdjy1lPza2fDwJEVbh3PMaKCJygiVjoxBqnxIR37NUkEAOpzJKs4I8oi4
	C9sFK+0TkAbT+XkyV1BOXkviba2r/h5hdR8NX1M72O3VsDOW4bk1dfZu861rWMKw0IiPtgZ7Jh+
	2v4UrA5D3dXx25c0ZUC9FyFllQxgXoSAi8ca9LGHtvTjXPN2mZy17CdSZeA/W4B4wZHz80YJvZR
	I49iFltC2I/+QGpWfNuAYiMHq7RS2Fe/ri+qw75ptFPQhc=
X-Google-Smtp-Source: AGHT+IEL9Q/TeE8X83a4D73J5c4BnqISbL2nsMzkDnt4Xq2JHmNtTfGl7cYLX08uLNv4xfpjIcH6KQ==
X-Received: by 2002:a17:902:f685:b0:216:5002:7341 with SMTP id d9443c01a7336-21a83fde2bcmr322676685ad.44.1736779144551;
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v8 10/11] selftests: net: Add python context manager for netns entering
Date: Mon, 13 Jan 2025 22:37:18 +0800
Message-ID: <20250113143719.7948-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change netns of current thread and switch back on context exit.
For example:

    with NetNSEnter("ns1"):
        ip("link add dummy0 type dummy")

The command be executed in netns "ns1".

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/lib/py/__init__.py |  2 +-
 tools/testing/selftests/net/lib/py/netns.py    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 54d8f5eba810..e2d6c7b63019 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index ecff85f9074f..8e9317044eef 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from .utils import ip
+import ctypes
 import random
 import string
 
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+
 
 class NetNS:
     def __init__(self, name=None):
@@ -29,3 +32,18 @@ class NetNS:
 
     def __repr__(self):
         return f"NetNS({self.name})"
+
+
+class NetNSEnter:
+    def __init__(self, ns_name):
+        self.ns_path = f"/run/netns/{ns_name}"
+
+    def __enter__(self):
+        self.saved = open("/proc/thread-self/ns/net")
+        with open(self.ns_path) as ns_file:
+            libc.setns(ns_file.fileno(), 0)
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        libc.setns(self.saved.fileno(), 0)
+        self.saved.close()
-- 
2.47.1

