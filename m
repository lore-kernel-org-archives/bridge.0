Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38981B0410
	for <bridge@lists.linux.dev>; Mon,  9 Dec 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753168; cv=none; b=p4RBzlHlwBFz9KZWqrXEid69Cca+GhMIscwQNHTcVewz72oWxLhEpkm/pxqxtZQCDjSDR5q5OXPjy97n9TaXWFoTKc6uF5rP5Oy46EsMqKg9RKCtJXwAGPXix0T0+yOxbDeKsqZSU0uHgNM5aeAjntQTL35GWC+KaxGEeDX5pbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753168; c=relaxed/simple;
	bh=PdyhCxIiCvxYyD0kNCUPOuthJbFGoqxPJVmAtqTiJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/zbH9wnTfrJ4EumzOHnrt7+qls93fkzK4VW/NF8rUhA+eRwr02e5rsTZAQurMaXObaeHPtXShZUoFGalTMYRTxJqcyArwSV+EVWeyfPlRubammYKcAcpfie2Ga7XyGRGsEjsUtWW/O+Xa8TKYpl74L0hxOtN0nVBFEe6TEfXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvR7B/mm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvR7B/mm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216395e151bso9208605ad.0
        for <bridge@lists.linux.dev>; Mon, 09 Dec 2024 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753166; x=1734357966; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=NvR7B/mm99YgRT6f/QW6fHQAbR6v/K9+fwgYQqng/Q+XLbbjSP67uNVlMxJ4QuMF/h
         rWv/Gm0rcoq6nsbUG84ImJc8TQTnK67Qlrn1hvoPAZNfs4aoU1y/4Vq8+XSiDJu6gHVx
         QNWyJNlSSK+TUGno2NDWJL90hUZ0dIZ0HuUcfXCsbVvtbu6keThiu/mFMcfJp+aNX6iJ
         ihRF6bxrTXINWvZWDEiupNNZnN/k1xmhP6CUEEDGEFjnJ9QFcOHcaaJGbiARAUGlIiPD
         xQKLYEpFuzPXFszQiPSTX80YpExambnE9FvlxG2X0S54Sbb5/5kKQt38/UJbKGljuLG+
         hi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753166; x=1734357966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=cKCl3ke/GFQ4rSahMBKFo5No2fVMZszBls7EgfGBem8UaUDdSv7ZaoN7lLKA70GydE
         J347FW8vOWa41JiJlnS+IlVF3PYVwApVtTiu0sHnG7wgLr+fLTcy74QQqUY7QY/th1/5
         sf0cEb3uQKS/00aXLH5F3ujFWpGAqLeLgIEpqGcp6+Zxu8BpO+85PW94aZRLhCgxYVT9
         CUDKYmA2wvq14Uhjb1nZwO7RXji3THVcG/3q0fw91OC0AJMdgjEGcPl+KKNg4rgqjJhN
         2oEvrVIDHwGJDuuxle6gGYtedQQ3Cp6qVavlpQjo+aUFmLDbodvND/3DadfvvQGspkaA
         odtw==
X-Forwarded-Encrypted: i=1; AJvYcCU52wk2N+KBMS09ZGSi9IBjRXcBQVnpeOucSXycKy2I/AwGJzAfmrugBhlv96laFgFuwNhqmdo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy38YV34tngpowtFeph2keCsryiSlKCHahX02BzxFLnDkAglYk3
	XfbcTtaPBEYUP3K2eC/ef5rgxubM8+HPc+D7zV5TVZ9p57u6l2dG
X-Gm-Gg: ASbGnctMmC6UjHZwaBtL+4j5u93eMQBkmep+MlBnTuJ6YHtgay5LWL5zewbr1JaT65S
	hMK9X12EJANGZmjq18XFfbh1sHQj3RDvUb/egNsLhNo41m/f9g5dYJAkshkt2JLaLyM5pQNGh1V
	K7JKev++5+3RecQj7q3/Xfg5XY7aignrYEBPM/G44OVcOTziWBfxg1+zPmOyYOnLU2SDaDwEJKt
	GsCvjK1j6Ghc3KNFcK65IkByR2S7sJhRye1oUQCy3SKm34=
X-Google-Smtp-Source: AGHT+IEgO+eAsdpey+DR5/LF2b2LrxgYAnjIwOd9wPEert31MRK25WTtIv1pjQ5j1prur61gIiJ4iQ==
X-Received: by 2002:a17:902:c949:b0:215:58be:334e with SMTP id d9443c01a7336-21610b3539amr198169675ad.10.1733753165835;
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
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
Subject: [PATCH net-next v5 4/5] selftests: net: Add python context manager for netns entering
Date: Mon,  9 Dec 2024 22:01:50 +0800
Message-ID: <20241209140151.231257-5-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
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

