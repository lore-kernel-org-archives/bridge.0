Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8E1A8F61
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995549; cv=none; b=iEc/KhJjf70p7450JP9d7VyugKGomNBTfwRSNQQQh/OHIIAX79wvd+x96BOvSW/dVciKxwwKGSkPjtFrPAPnngF3VusmvW6NWxqW6bRD8Xv7zvR2AmFRN5+Z61UGtjOOinnluXr4ztjg2L+Si7N8tx6mXhLw6+/Q1/50Rf9coh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995549; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmBF5Gp4O3BCnMnjYt5I2QNBMvANtvBnD5hbl7xq0McoH0L1mxoXTDynStJWkzwtEjGIDHCjwE4mxukBozjuq2pJVB8feG3wz4UroSZfgxU2YHgTYJtiPj4/2fJ2VYAUfjkMuL7Kg1IOnXDmL1DNIfWT+jW28qds9WqeE/ffUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+JC76RW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+JC76RW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21675fd60feso241716315ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995547; x=1736600347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=Q+JC76RWE7KDvQx7zwe1JBGgV2x0ViOl+N0DqOnOq8ttsWERcPfPgUpVPHZkxmHCYK
         yN8wm1Y9zjaUOj7Cd1PEUuTTNmX3Vkr6jTLiVbYPnWOC5q9nT8phoTtL85NncH++PZb3
         JaM2Qrdbwb19lqkrLiLFJLaw+ibu/SkFLITY0Nu69vOyorfY5jr0lltSgVAcEn3DKa19
         NHLyfa3lTCZW2orwv47Ij/vILIrnGSI8SHBi3Ex60u9gSbbXgLPV8O9gLgPC4VnBQlR9
         IzlElRISOk9AsLOHHGctLlF/vTwM1jD1ry7Y/n57StoL7DSa1Xlxyuqf6wpzvixX2UTh
         Iw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995547; x=1736600347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=U3+wrIZEgWR8AV09moRsuA5z4YFPqXZhKhrz2MuiZahGe10VCkxIUAimLIbihssB9Q
         iZQM5QQSJvNnRI/o5pE08Fln5SdXCG1rJCuETh0YzoxWzyN33SUv2Ba5IpO9DfzhoR56
         /FA7uY+jgZNm/4pjC/xUMGndQfUcdn+sa1HU+ptMq6ePppiw9J1kYOF7wBFb7r+Frvlm
         xGkC9GJ1hmQJYii11SIlhWO4CbFQD3oAHKKCOTw0kD/Kef5s4Xq/RtJSHZu8iRH5Lth7
         T4+xpZjKSvUei30yg67r9LMbPm9GU2eoD5nrVGKoHZsG+OODVm9kujAY+CrfAiUCD4zS
         U4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWoPr7G9ASDnnCHh4QiUB5k/EjZtHJEA3nafjfL6Ni66om1tN1/QAPwnfnrm17dcXBDzgTpx1U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwDvXFFfSpq4OgqvjoOA/CSeNA2OvXMOeOGns4isz/kGdNWsfJU
	g1bxSOGv229mtnj2WWrqqLpnz0rFlVz1CiV25l0dZ1FRXWL+ayZ6
X-Gm-Gg: ASbGncuSmP0Tmb4q9OsyZe7kj5ILzon37kzpdwwsREwb7157n409gPtxqJnf3t9OEVi
	7LO6UfKWHgT7U+KkHMEt/90qezKO4APxJEGL8nZzbgWaET8llb1sCTuTuioXQPPAbXkORxoGxlP
	fb1aIwGHJVZfK+dn9J4hZfZCPwKwKm4gXmLrhtDcOgdY+riGMrEao1tMd9fPNmgd4M4ph//ZogJ
	ArxvzqtQG/Fk1ZDS3OQTlfPumWchE4FskVJF0eKPfXHRvM=
X-Google-Smtp-Source: AGHT+IGUseWUHEPuZ2azBnIbXH4/rAn+CSEtKsSSu9kCqJsAhEDYnxH1YaaDUJFfNwCRIx8vP1I8ew==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:dbfd:1fde with SMTP id adf61e73a8af0-1e5e04a3427mr79059917637.27.1735995547161;
        Sat, 04 Jan 2025 04:59:07 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:59:06 -0800 (PST)
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
Subject: [PATCH net-next v7 10/11] selftests: net: Add python context manager for netns entering
Date: Sat,  4 Jan 2025 20:57:31 +0800
Message-ID: <20250104125732.17335-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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

