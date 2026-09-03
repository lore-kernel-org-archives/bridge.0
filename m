Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE4345CC0
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445927; cv=none; b=ls+UpYNVDo2m6bkYZGB6K3wJgF0TJU7FM2SHQzun5GhxYVFMEFC0z1Ysd9k5gEuTsDrMhkfg3dplnQP1VLkCZtjIRiLbjqNimvRxnPCnWWhG248rrSgfX85VuiKbuxCtJJ2cn+49s7zaNyC1DbTWei+D63Nr0XusvZ2uq946JYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445927; c=relaxed/simple;
	bh=B0IsA/lAeJ4qXMhNIAjjpDlfI19ISSUxT5j/DHGlB/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jarA30IGWtesY7B79bd+sX+sDUOpQkk8OKlw0tuda4RJF3iWfdwUuatyQ7MIBCc+A0KEA4ycnSCm+C0O1lEcEEZR9Iftp9XDmSRofIgrguMbEJZ7ozxjGb/Ek/juIt698ehqV7UJQby3+E7p1IM/Cv7kgfXtTtvD3u1wwMM6Se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=f3zD8VPI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="f3zD8VPI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso19877105e9.3
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445917; x=1789050717; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDQk0GUSPZMdmUwgzdH89AyO+OXROlqVMrjjdPFDraw=;
        b=f3zD8VPIKcZpee20uQYp6AauA6+uOXWZJspzTwZgyq0A3LWJSKq81BPTIRZBzIRwYZ
         btoOYJVilcTYWdfQWdxBkwgtW+BeFWZq4v2c74czLrYfcaPuDf9lu1B+FgScouSXVVbY
         Xn3asbDMIUjtY5NLCAF+9A/MRVKtI8bdjZ3m17AHcLwHnEj5oMHx/7fqKlVslr14p/3u
         9IxO/v7MOmSO3TRWCTcNjMZ/twx7iC5YKY2z2ySp9FsIVp9FmbDLf7005/W3ner77HaD
         t4gZ5VCZMKIGYkC9XACbhGTNXv+3E4ZmM1+tHtltqoeJTbRBuK5u93q9Rc+V3Psxdm52
         46yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445917; x=1789050717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDQk0GUSPZMdmUwgzdH89AyO+OXROlqVMrjjdPFDraw=;
        b=pQUYim/u9pU7xtq4WlF49uYXgndswAa4bSdleEyAhTv0maTzsiqXX9s/5jTMVex7D9
         aVmAGEvJvciewk4q8nftIql9BeQjrcI3DzJ+6XLtxRFwYyrUVdI71w1Mw9F4DzKteRNF
         SNqwoNk4VQan9XqVezNjZ6hecU6MLL1BvYmGW3mAm6SfWv9JSnapJrNPI1nalBNirdnC
         mubK2pWU42rmetJ5Ct4VbQP86+kGyKnxMELAYCdzEEfPPFcjBkIvnmGr9njL2hMC4+6N
         HPFNUdO/Z6OEcWaccYVFxHzFuvP6W4m67kzo8vtTfKYWKOlhJbeZ+Xt4M7zO7tkst7UL
         Sqyw==
X-Forwarded-Encrypted: i=1; AKwUvBxIMizmEfBm1xeQjpu+KNqYKzDJMYBN6+AbbTCyr4lOuVZmL1RyS5Ee/AfHbdsPvKhJ6n1zpKc=@lists.linux.dev
X-Gm-Message-State: AFuF++nijMj5YsNLIFj0yp4Y9TrYVW/pWHW9jQKLiYFbCLiDpENF1RS6
	T0vdv6nbcjAp/vNJrw7sgDrARj4kK3CGofhc3drqWxv2ZZECp3fBGEiZODKZdfj3bM0=
X-Gm-Gg: AYBFou0L8TY4K4SVg1tZtOhUCc7LLFH1pkLrUg5T1zRrR9t2R4NqCYu7h2zmOBf16Fh
	3JKfrSw/fpOrndouwI2PUZbgruYUc+4KYVGWjfoMFu5P1ruQA6updQwYNH2BVmPls+v+Fv+fcaV
	kXl/TPiyw/INfffQmqcTOQvgMlTwRDt1ro4tOVqd9N4Ze/xyWsxW1wU5iF0S8JU1bLOiuubyaox
	zrwXx+VsRM4aZvPWNUY+Yu7uPWSYo2Qx389mzpCHMfY+sQi1HRKe0+J5qkyiSTFID4YYLT/8AcW
	argqjhFgYMSQPPq8hvSnapaiabd63V77itomrAtkL/4NrPl591rG8mxFtFuWuwxkKJZIjbqxeff
	O3p40tn8bTqkaw6Zo0YpufkADUMKfJz45/2RFteqb/ATiaJ1q9goCEtPb2L6Xf50c9QJtX/OAu5
	32LMztRj0npxgNzoPpvFCijJ4AaeleibOqbrow+X8FnSZV0jlg1/31hoAFNVgS3v2PdTdBNpp0F
	CsUGL1P+vkPxxyE/SXLCA==
X-Received: by 2002:a05:600c:1987:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49ce582266fmr203228995e9.12.1788445917298;
        Thu, 03 Sep 2026 07:31:57 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d5d12sm74324245e9.5.2026.09.03.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:56 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 0/9] net: bridge: vlan: minor cleanups and annotations
Date: Thu,  3 Sep 2026 17:31:29 +0300
Message-ID: <20260903143138.1574598-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
In preparation for a complete vlan fast-path re-work, this set cleans up
a few minor things - removing legacy code barriers that don't help,
                     annotating lockless accesses and using proper helpers.
No functional changes are intended. Sashiko will find many pre-existing
problems, none of them are related to this set. I will try to fix
everything pre-existing separately in -net, there will probably be a few
critical items. So if there are missed places to annotate, or if there're
actual functional changes, these obviously should be addressed in this set.


v2: fix a bit longer lines in patch 8 (were 83 chars)
    fix patch 9, many places were missed, use br_vlan_get_state
    consistently (Ido)

Thanks,
 Nik

Nikolay Aleksandrov (9):
  net: bridge: vlan: drop legacy memory barriers
  net: bridge: vlan: annotate lockless pvid use
  net: bridge: mst: use br_get_pvid helper
  net: bridge: vlan: annotate lockless vlan flags use
  net: bridge: vlan: annotate lockless use of private flags
  net: bridge: vlan: annotate lockless use of num_vlans
  net: bridge: vlan: annotate lockless use of msti
  net: bridge: vlan: add missing tinfo.tunnel_id annotations
  net: bridge: use br_vlan_get_state to get vlan state

 net/bridge/br_arp_nd_proxy.c   |  6 ++++--
 net/bridge/br_mst.c            | 19 ++++++++++-------
 net/bridge/br_multicast.c      | 18 ++++++++++------
 net/bridge/br_netlink.c        | 10 ++++-----
 net/bridge/br_netlink_tunnel.c | 14 ++++++------
 net/bridge/br_private.h        | 37 +++++++++++++++++---------------
 net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
 net/bridge/br_vlan_options.c   |  8 ++++---
 net/bridge/br_vlan_tunnel.c    |  2 +-
 9 files changed, 85 insertions(+), 68 deletions(-)

-- 
2.47.3

