Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABE1F03EF
	for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192191; cv=none; b=m5pcgFpL0s0fPoETpZ49MY7IZo0llyQknPCjDts/rvH8BnxfL6mFUsSCQUEgeKBshVGUnNmrGLJ3YAByWrzaM3RRlUxij2KnjQdb0UhOGb9HUjKBJLB11hmZd/a0TDtURCIDgYbp6DTnCNYaIk1kSiVbmJNGTBIY+SFAlcs8Anc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192191; c=relaxed/simple;
	bh=HL9Z8exH0p8ghijOUjxjCoBmCDjBhhDKtkS3KASOoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtwVuF1I3f7nHRFYADRoEj1cCRdpMdxoqAKe9P2b3NxiQW2SH4gBEZnU6+8ua/QeLkT1SrsKIUyhQDI2RrPOyXeA2huE6Ap9W550yoD+Qh/OroYAepZ0f7Q9oAKxazY8VAJfeY76OYh+RyJc4Y4++RM028fKgCsGilRx0kbgV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjrLfcIc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjrLfcIc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c52f15c5b3so261872685a.3
        for <bridge@lists.linux.dev>; Fri, 23 Jan 2026 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192189; x=1769796989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zF0a10J5mLJVO6RkpWuar6FLLd6MMCZJu1XiB3Hvb/Q=;
        b=jjrLfcIcJd2j6K9KH8A7Kv1JeHWJDVcvoQWmwkEInW89/f5pEGqRpZAxGA5/oIwaR+
         1F/a6NmEEs2yo71RQaB7QxtJxJKwNQ0fRl4Yef+cBndNOtv2eCWeAhprcs+t7e6zkD+5
         XP4ysknuHmWT+CFFPyJphlPgfoWCofH22YLdZGFx1UhV4dKTPeT9ezxyiqpYR6A1J+vo
         w/iDqp+50rfjeJ3oSuNYrABdM44TRQeGv9HldknGKs+ZxSYiiw0bByBzG12HfrfHqjZd
         Lf34pHL/VsnTjhTgmr0wcEDqhDSyMsaPvfDmFSP7MWMXCa+QbyBjW5KJt9bRJN47PURZ
         v2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192189; x=1769796989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF0a10J5mLJVO6RkpWuar6FLLd6MMCZJu1XiB3Hvb/Q=;
        b=iCCUt0brBEsGiBRe5FSWw8sVKArSe6n517CsrVHjJoBx0TS3rDTnUhGwv63SpMHRBN
         V5qebLIHtrfy0nyr5tucQ0RhYL/+k/lS0rkAktFBLgSF2pL2QYh50AAomLDh1WQwdkap
         hlzPuTf6tCjmF0XCOZHQEwNDuZ5kEB0dW8yH2k3ro57ATwAwlEMALF0eP7TdCQexU9p0
         SGgqiI+JV30lSJwjb+NuUBchiGddZxNXOcwy407D5vdG1mHWUvRyPWjKwrYN1dKQYh7T
         4+LAxA5qobTjFmCOf93ZEpyAFLIgrfBP7kyOi4OLoDgdTVLWvrDRZnZLtmPfHLDbvokL
         HRrg==
X-Forwarded-Encrypted: i=1; AJvYcCVUFXTey/smIzLnMFuTOnsSHQJfcRj5RhmNLsZvpzXtfEBYvBuQLB0uBU4uWbZ2w88xVwLHLZo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUq/v4zHpuwVQDnbP9flat4r4gpM19m5XTloQM8Klt92esywuM
	aSrxHv5ljMPWQZ3GopCongAV0/NRo0DGgYThEpnm9NoqBUb2Be0JDbwhd+jqhA==
X-Gm-Gg: AZuq6aImlSAQ2K65IWrGTAYV+jm+Y0mIEIyp3kEGPufAFeCL9C4dCFt0S5wDVRnkfpH
	eocLLkPDS4tgeRdMtTLsOVz0LBzI2qCLA6VKISYYFjb18gbZFmKZPy5B+a7nxF6RQ1SOcOPV+AY
	lr6CP0LBehOXXlnAsBSsJppT5Q0WgUTUIl5wYtq4bcmzeY16olJ0b7UORN/VQ5rumnEsStRtYU4
	0XKi8ixBalpjZwLRGD5jq4KNOCwY3JYGM8pdAe9cC2SmYnuy7vZMuPRwSwUfXQEjNMunNHc8rOW
	ODqX1WZYO3TPmn5PAbyVS73bRYona9ULPQT8X7pK4KrrVk4WuUqGg0UAS6pwjCuQoV7FsCTBjOj
	9qzzs0nFZf+5V7AT+tys86ltS4AfASwPInIIXXde/mx8fFxqefSXAbI7IvEa4rgE8EBEb2KhLKL
	+EFn/0aOMxfqoiIBB7m0u+VTAu16H/tadTY9AcAvDpgTyv0dZ/xcY+qG4jsb5VeId2
X-Received: by 2002:a17:90b:17ca:b0:33b:cfac:d5c6 with SMTP id 98e67ed59e1d1-3537af9505emr1485005a91.29.1769185336053;
        Fri, 23 Jan 2026 08:22:16 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:15 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Breno Leitao <leitao@debian.org>,
	Carolina Jubran <cjubran@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	dev@openvswitch.org
Subject: [PATCH net-next v2 0/7] u64_stats: Introduce u64_stats_reads()
Date: Sat, 24 Jan 2026 00:21:32 +0800
Message-ID: <20260123162159.2877941-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() and struct copying should not be
considered tear-free. Use u64_stats_reads() instead.

v1: https://lore.kernel.org/r/20260120092137.2161162-1-mmyangfl@gmail.com
  - rename to u64_stats_reads() to clarify data flow direction
  - refine the implementation
  - add docs
  - fix struct copying too

David Yang (7):
  u64_stats: Introduce u64_stats_reads()
  u64_stats: Doc incorrect usage with plain variables
  net: bridge: mcast: fix memcpy with u64_stats
  net: openvswitch: fix load tearing with u64_stats
  macsec: fix memcpy with u64_stats
  mpls: Fix load tearing with u64_stats
  vxlan: vnifilter: fix memcpy with u64_stats

 drivers/net/macsec.c                |  6 ++--
 drivers/net/vxlan/vxlan_vnifilter.c |  2 +-
 include/linux/u64_stats_sync.h      | 56 ++++++++++++++++++++++++-----
 net/bridge/br_multicast.c           |  2 +-
 net/mpls/af_mpls.c                  |  2 +-
 net/openvswitch/datapath.c          |  3 +-
 6 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.51.0

