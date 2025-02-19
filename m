Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05D1EB5D5
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969563; cv=none; b=F4lw/jY7CA0pdOkGXR8IArf7dadHljFTu45rb5qQsOQLKBd3dIIMD4q6o1dkCSZVO8RL7wsl5T/0eo+LaKveK6lpgfGEi4t/2mFYdd2CQUrzQ6L9+SHaRzlh+DFiReo5tu2KCkaUebQoJgloXc3qNbea9f2qNpeb0FB08lp5jfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969563; c=relaxed/simple;
	bh=d5YqzA1/hOIwxn+aPZBjNIWViPAXuH4DTCUtu2j0BLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCDrsWVx0nQTyRMAX0rCW6nLszIJe1577pC6ZSCj8WKoM6Jj8kBBdS/ORwmW/LuKPntkxPX5ixEdfZpzAm9Y8ahKOwPy4Dj74Gc/WmSQF3dM4hjHwzjhySCnHKxGXZ29lbP6ULwl6vF2v3XaiOwPW9bxpRSWbkq1DvgKgHxPtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1T81pOe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1T81pOe"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so10124294a91.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969562; x=1740574362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=Z1T81pOeI0VnYY8irTDj/N3vZZUzJxidhHGUtaXcU0lFaaMmcHUvcTDYZ80MVEPLYe
         kavbGU9d5SederCLf4gHLsokwSqYFJri+0uFX4Kle0GbXqlViQGjxfEYUAeroRxAC9z6
         gLmTnXeQ9rADPKKDAECHT5cDpJjarSawg579uVSF4eD9xeE4FYddY5Qx3+X13iW5yKsM
         LSuOLPrpbQAF3XlhEQKIgw/u9qTuWdeqiugQYgmGmq6KSGVf9r0GodNAnTETTN0/hClI
         Kta9KFiNDBWGT3bppfgQrwodG8LUn6e8LoM48J/oF1qdzCrS4KLVdlcCWJwIEQrM1Aj/
         taUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969562; x=1740574362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=Ob5aA9dEQNLR0Y+EBcbsWyuT7N6Wlv58uYzOLntIjzMFDjiH7CWAE2fUtA8pBDGIjj
         7m+R7UqLDSya3tFHNMWJsxI9PWPkILsdgS9kwlCpr0NigNWcYw5/CCfGzKhcbU1Y7vS0
         4p1t2IQtbxPih+5WoMId46GDHNn6Ndjj7BOUIB8Zq+/D84oa6Jw2K1HxXPDjTIRgWUYm
         f+suUQJ8AeSBhjNHZLOsmfIJBGhcK1Cwaqlf6h3u9QHpUvx1lSkFMHwE9l1LIudELbbU
         tY8e8MNrb2+CUuNuZruOa82JZ48lqSWJIHadVlLE79w1y/q8+LJdFQZRL+G217z4ynVc
         j91g==
X-Forwarded-Encrypted: i=1; AJvYcCVR2egdAKzVyeQ+Ki0b1IXAJ4SbY4D03nvlG9o0yd0dqvoIPunKV3l3Bqy9sOZEFKMQvO4Ha6g=@lists.linux.dev
X-Gm-Message-State: AOJu0YyaTKzEZjN17kq0Dd47xLSxqDWD8hhXvLU11shjlDeB+dZ4LkBe
	XQT0EUubEVw/RRo2GUFMG8pt/bzFvXkpAx5/vqPoD9knfJg8SHnf
X-Gm-Gg: ASbGncul2sB4sIE0hSr7bzYURbVE16dPPOzIMQ3dOAQJuciM4dyQA7EdeaNgJY3YoIL
	Y1EOoL09I+pNIoLCSIKBgla9lixAIzEq304/JuU7rG8biJ/mUlOcWH+PkiY5xBQoBJYoZeKtblq
	qvACGxaBTJEqRaL++wDmuaDj5ALZXZKP+rqmBJ9FcYqD7gAmji+bG3MhKxKtbVx+a5gaH7geFXa
	8XQL2KTeUeXJJB4UCtEl8hSYRY97eR3TjtgbRe5FXEuIn0lp9fNnMV6xNiQbe6r1DoSNxRazs/3
	9VQLtA==
X-Google-Smtp-Source: AGHT+IHPqeS3VaEOgvZ8Tx3PUVaGMIEIbKpPjORqTeM6yeMS+BbAs1PKrGLT5/zDq05f9NI0VnGgXw==
X-Received: by 2002:a17:90b:2887:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2fc40f26600mr24663034a91.21.1739969561721;
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
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
Subject: [PATCH net-next v10 12/13] selftests: net: Add python context manager for netns entering
Date: Wed, 19 Feb 2025 20:50:38 +0800
Message-ID: <20250219125039.18024-13-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index 729457859316..8697bd27dc30 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
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
2.48.1

