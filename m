Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117F19CC17
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527448; cv=none; b=H5l7MSiCn5O3mUszBWnTy0Hy9Kcl6tb53ziBgYShcNvZlkL2nQe0AaIni3CRiA7mjaPfl4tORT4fj5DezdoX7L7qxkB+Dk8lBsvGxWiU3+MIuBI/r3j1NA43UwWEYs7bZtY9LKpQqTTRuNDnGlprd4C6riNicRBRbTh463glqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527448; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcySzSGvCmQ+dVvz3RhsWtn310jkFKzC67QlCvAm1A97cM0SQDkp1VTIlpECaM8t6BI8u4pM2Ci1ehFZEa+lQS/78v5a58jo4F5FETHgXJGl7T/Y/ZSvqMv35Q3DPbTO+Res6ME5RxTslyHFfnr5US+r+VLT4tCtz3HuaAA7Rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbTselxw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbTselxw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725d9f57d90so4834040b3a.1
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527446; x=1735132246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=RbTselxwkIj3OL9GUyFBqT/ya/V7e6NfUEVxsb0XWpbsSH0GcBd5fMhub+I1XZQngJ
         R89J8uUdhS6pjL2FGyD4aVmYtHjY7hwzBVnHC4VVaxA5QkW0nbEIuUIB2h/9GG0BEN0o
         4qj/gIRItDxR9vfxNZkJXEAlT/jTsOZ/K8Z7OCikbkjNOyp5HzHiww3wfyYGSe6x3P6i
         OxTK7BlxkI8oqVB2a3n48kOZgrBE6bYkoTtFRtfQ69D5PV2G5Pc669VWVNCOdkyRHLJH
         AKkkRD4FWVZSmTfD07+PY7Rdsn4TBoUGcwEN3csEquFsp7sL8TWrZLAdXv9dq8CZLAh+
         Mzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527446; x=1735132246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=olxS8JnhGCmez4CjfjiiZXjgr9SouMJtFPvXzH532ACMcogV8PWiz3JKsf2lxu1Zqy
         TLBwY5+HHkQjcNP/C6jgVXOO1aNMA4Ef+gj9ltyhOoM57SVmQFKfJm9tSlkXehv5C+Wp
         Garjq4qhTY+UmlLV/0o8qD5LYEOCvD62NKCX6YvJp2NNR35umIGkMz6fT+AVSbwNi5E1
         XgyRY7yzUPZOEt8Ljf8MiWGhaP2MteDBga9H6YgMSL/UgBxHJ1hOg05mtmnQ6gVUMhLT
         8r5OqkMmrDSkG4t7YKgxmjbFj+5NbkdY0Ks+ONBvd4mo30hoKTsJcFUzfOALdYmGLjcf
         axXw==
X-Forwarded-Encrypted: i=1; AJvYcCXEnLiiSpo2aElRuZYWW9vDMlnxXVS+vPzzb2E9O4ejwljuZT3lCf318BQxTBPV1KXfC98WyH0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzkgDbFd3vs9ecEkBGOGvZa+HPZfDBiEWyQnzAvcil3Fk6fTe4D
	gX5CEkTyDa9ZyaFZxYrKBdM0aHKVjlUDnoqkWI7/RMv5zey9gtd0
X-Gm-Gg: ASbGncuXeJEKr4xxXr2Muttlx+nTxP79s4ecw70opb9lp4uW+0JBVtA052OBeKSHnzi
	esSufei4pZtZ+xjdoURcJ/6Ru8pPyRiy7bvZe8NZIlNUAVjBKJufMjy+qE0G0kQmS0ES2hT6klX
	IvY9Qmc8ZzPHDHY/Kqth5Bt4sD927Q68KxGn8JlI7Bzq/gPfrV3j416Tdux78EFg2qQaE5NQrjP
	fSOXRzUAjgoju+0aeplf8VNAWxf5OsvQKEwvhx7zmAmDqQ=
X-Google-Smtp-Source: AGHT+IFJSba0hMYoxDtWWfQo3+fMH+6cNLxoIt5yunX4KkQHyaeVCZq9fnVPYHJO8DT42j8sEsCrNg==
X-Received: by 2002:a05:6a21:6f02:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1e5b47f3b12mr5217374637.8.1734527446438;
        Wed, 18 Dec 2024 05:10:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:45 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 10/11] selftests: net: Add python context manager for netns entering
Date: Wed, 18 Dec 2024 21:09:08 +0800
Message-ID: <20241218130909.2173-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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

