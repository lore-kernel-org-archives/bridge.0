Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7311AA1EA
	for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940430; cv=none; b=LGPr4zokdHPKFmvOqRnqPytjTAiqnQh1hjm/wORm5E69PJ3bPNFfbcRHLrc/E6UWJkDBLB23EWbwi2Gxu97iBzGcFBxyIkpASl9gIfTdKHbMsly+ZaMRFSVHg9JHNm1UFyN9rBR9piXvHl0/I/X2F9MWqKEWhqJU3EZZgLVF9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940430; c=relaxed/simple;
	bh=P49fr9H0xVRpU4qpX215T6Lw8ChU2UXvkXGar2kWP84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAOOKqn42ksrQKXjvkAjTO42TvFDfJBCdE/lGrLMWGvqa0zj9wPAS5MusKG5wCUx5GUre5lQ0KSDwfmLoQAKJCy9audIth0GZMprmcnJYVqkmSwpVvkBGOLHCPeo6/o+OPmfoAShV0TQM5vI1UwyZMLDZcv0JsxknDTBkLeT54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1PlBbKK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1PlBbKK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72467c35ddeso3022206b3a.0
        for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940428; x=1732545228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=C1PlBbKKY9VGim8DGrxAiotcAqrTQpNNpCdtXj3K7Fz0eQDvVI3TzbYIlJNGDV8qT0
         m/Ez+pYJnnlxqUgQp9UBgPEgipuaIo2sba6G5XkKB9tNVOeVc52pF2WLrBq+kb1XFgI3
         3+OTGZhzALwoJRe9ILcsGLc37plutMt+FSaC0SK7yZqvdMTiKtoDKkQybial8iDly3XS
         VN5HJWeWrdghZC9w3UwWAYqNqv543HcL1zSNBRRyPTPul465dhZHqkCYshAYa0nq9ZEb
         eD6Qd46dbZwom/1arbJR98Mzvop+XdSq/rFxfnsYVm720JbkXgFlC0b/nZFBDSUjl7vj
         shWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940428; x=1732545228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=IyKtbZ0MzrW3BVdT4TE4K+SJL/vjqViKzb6YzXaFm+j+TJ1zR5bS9BpFAlFT1z4zuq
         hGi4iex+Qqqlm8Uyl/ZcZEplHzbtMNInVxmIBEIaTDW9fRIfxm3OrzO3jQywxh6evtIs
         FFybw3I9OWouKUuOZKU895uVvDNdoTYSJ3MxQnbRWRbFeoJIQZJmEO0Cigf0bRv62kCt
         avfAms4KFTOXumIFhzEOue/vzzubbStevMj1kMUt5xbHIBZfspQ813LmQ9xKms9u36cT
         sSWEtVzpJdu6HiZzgWqG6HMb5HcjLRvLXrMjnioiJhDjJxNaKMtYLSaKj8RRmm0m2a9x
         oeJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHoVEvpEiVPm74sDmzpcJ84D2iU2nJBZYO9iiCmCfqGrI44djjStVANNQEzT9g1wD2/M4LF9U=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxhcn8ZT8ukTQ2HscmX2s1D5uIncysHDCnRazX8W7XmQKyaFmp
	qSLvxmGXT72sQ3gN2kuDeDYBOmzM/CJwSkjIMsfFtVOXWjjNW+S+my90cA6ZtYY=
X-Google-Smtp-Source: AGHT+IEB4OLbXUI9lGpusUMTTQj7CZMlri2szirQ6bOEHE+aXQRtMaJMjzV66+oDEF7uQxq+tjw2ug==
X-Received: by 2002:a17:90b:4a87:b0:2ea:7bdd:f320 with SMTP id 98e67ed59e1d1-2ea7bddf3c1mr5084481a91.1.1731940427545;
        Mon, 18 Nov 2024 06:33:47 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:46 -0800 (PST)
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
Subject: [PATCH net-next v4 4/5] selftests: net: Add python context manager for netns entering
Date: Mon, 18 Nov 2024 22:32:43 +0800
Message-ID: <20241118143244.1773-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
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
2.47.0

