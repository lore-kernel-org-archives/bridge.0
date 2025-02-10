Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376F22F15D
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194310; cv=none; b=nCaJFTMCZ1Np9stLrjBw3caRZxqWdI40ox/NnMPvJBbqgXtHkVCmOJuhVZ9X5fMg+xTmy3SotqWVkscCiH8V7QOuVbROSwul+SA8caEgv6hjEm2MZ0VFkSJ7imZN4YdyFblJPzHE8MtHoaH/U1dH6Q5GNXy4Xr948rfExmXx4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194310; c=relaxed/simple;
	bh=lzUgC/O1T6CC8pluTdthNoUVgnv/C+cqDItFQE9UsXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsOSlXvvSBu4q7+AzzBtQFiy3N2VGjyrBfgXyKHLDqLWhykMtk1ih6Npz93qML2WioOuLTX+Lwsd/k3tpxrQ7a5q/zAdNO10GYuzVFKXOl995o5HsgcP1/AoFYtFReJTIFvZxfxd9yky6JFlfWdMZWTa5kBt7PziNBaUCvo0rOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh6k58T0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh6k58T0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa2eb7eb45so4112141a91.1
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194308; x=1739799108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=jh6k58T0vXHZASgixi7fOMgg3QQuBTAG418yxoxZlIjXjBnDNfEkEQlbG42+vHqhd8
         /mdevWKaKF4EPCtQ/61jiIIRbD9Lv3Nx3UCfvSf6VgNwex+1DlkISw77PQbia0PVdelP
         wiqCkVHO2h82XgeH7wR1QHm3Ncne74mYXluvn/F0lIXKuWdOQIGh5VQj/JuCa31UIDsp
         mHljL2obGMl9CYZf7lPERgeKBCL7VZ6RXIeU5tcFdBej+62rV2FqBjOaRNKz9NOMQ2Ah
         0PY2301RXVwoybr3XeTd4ySZR447SpoowSGbd4lkf26r89L/BKA3ilfxNp7/zdvsysJo
         7KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194308; x=1739799108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=Q8eZjjXhMdiodnI0A1CqvZLEtXGaD/Xnnlu4S5SecSPLjb2CAVplQ89gNYKb739Mem
         kh188n0uUGlGfNKyIVVf26c9uosSIQR00GHSbv2KH+vWXJVvO1FPpH3AN5fWPr7Y8E+r
         Yr8l0iH2C/2Q0s4HXbIY0A4p38Yu9REPqQOVZqqOuaOQxl2cpHperG8IvPaTVq6ruO0K
         KyIygCeS9YJesRZO6Pl5/DX1yeU/lw4FiRoXgZpTSoUMHFy16HPARmrrfK49xW8Dthw9
         9H0XtDQLgY2HRO2ZOAujdJHIK6Ry9uazqW4ydgwwq89iFj0uXHBrKml7ElQ7+X9NtN4v
         2rVA==
X-Forwarded-Encrypted: i=1; AJvYcCXyJcnHGv+6Tiz/kFQcwv1FL+zVSU2pebNv+6aqlDHXa16OAh/dXH6nAe52Hzgl/SwSOUCJNyM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3IdMhS6aDld3naJR0K7XVVloII4Icetle5vUofJiI/zNvIHpq
	1XXMgDlsw7r/h37vfive6RTqbKozNh1J66gM733PXUTbX7JIIkA/
X-Gm-Gg: ASbGncsyw4qQ+p0BsvlM9oJ/N5LVcjQe7aU9ZpDUWLfD8ei8VDKUf0l0+bmSNCfDdou
	TUyD3ItVZp2isvq3oRKF5xAgXDUP0WP8YV/BzodREW91kYvVfS38mytqYAD6Et0/eO4CuOvLkxr
	yhx88x7dFbDYjkF0TNvdxFOPsKav06fDTb73af1YJ10XnEeE1vRfoqbzKbRMF7HxqcPp5zfh/V7
	t8wi2ZUdZDhBZbt0UwhdMJGgSB/4Evr3OiYlB5c/4ikJgvYpDQRMmSBARzF0gM2bMh9FaEuKoDH
	K1ldUQ==
X-Google-Smtp-Source: AGHT+IFPiBsnnOAy2e8DGACZaeMc4ZZCgfCsAVv3/+u7QA91zVdRjIX/zkP0E7/3XIVhHqlMh6JYtA==
X-Received: by 2002:a17:90b:350e:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-2f9ffb7ba83mr30255082a91.15.1739194308152;
        Mon, 10 Feb 2025 05:31:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:47 -0800 (PST)
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
Subject: [PATCH net-next v9 10/11] selftests: net: Add python context manager for netns entering
Date: Mon, 10 Feb 2025 21:30:01 +0800
Message-ID: <20250210133002.883422-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
2.48.1

