Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D248D89A
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211209; cv=none; b=ncNiw0wO//KmptxvAPjMwrS6hSdEeIBNo9zF5qGqwQ9vtLYerJkzqDQ0eabfm13qGCQ9eB1mnCqwJPK1s/DGRV5FhSJT5wV02IH6sCDAs1U3RT+HQBo0k15z016FoJ71cmC5hjGfVuOpxA/PNQmo28P4As3mWBOafgoJnl5tXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211209; c=relaxed/simple;
	bh=p0XxDjIkMow/otiJs/0jA2ZFfuycIzlWTB/nybIO7xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVPk3Qt+O3s8TmciBmH0yD1m+r3lSJMnSMqcs/VgZUv00hKO4Bw4Qe8RRcFRECvIRderhKmWumJ5+qnYgjqoHKLVBMYgXPqnL53hk2E9YqY6AEOuZikwTtwQOZqIpEBK+P02VwCLm3sY7K/YwqwfpwTKdHHDbDsR4wLl9iKFXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NLKSJ5cx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NLKSJ5cx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so8447535e9.3
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211194; x=1791815994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJyOJBzmps9x+F3wj+b0umWwMs4AcgWRN6f7/jPJhEA=;
        b=NLKSJ5cxORBFhn3W8vsfFeuBjXIZehkK9i7M9lak/hp+VOBFcYh/YrmO6mSNefBNZV
         vpwLgT3sHW9wKYfWdc35+yvWoiWrXp8Tz6NcEhdC0CvE3gQAiMjaJolGFWTkWCwaC59N
         74+s6GIaPePaaUOxdUQ9vRi45OJnzo339yEUq3dhQxaau0+XNZAzLk+7DzY8XvuqBMBm
         kXzdzoio5qUWjAwpRgwv7lRpq2w/5RcB04n4/XPGoZC54fXHuZ49FwVF0hebr5lQuH5K
         SRSHI7s9gICVLZMkajfS83dfM/DYBGWJfBAhluuxsMGylCP8c2kOXFVOLv+vVjnKgvrd
         a+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211194; x=1791815994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJyOJBzmps9x+F3wj+b0umWwMs4AcgWRN6f7/jPJhEA=;
        b=k3v8XrP0J84u2dD5ti2UwhtvgoJGboz6pOmwjf0NIMsA2S2WE3Gf2aHDORqkeAC9GK
         f8s59nxRl3cK1iLsLwIN+gzaOS3Js2cnZYwxzejJejOflG7PS+KR85VnzopAGdcax9pP
         9bAXCY79WQbMtLF72s40lr30Y0QcqytVG50+rdeK/AF+nFBb0oi6XQALj6+XorXNesYN
         Z+S38qn/Ha78QGdNQzaWch4+qXRnneIzLYWe9SXw0dsv7iY9ac2I9k6HwAm54Que92YT
         swSgkYXqCO/URvvKzvQLMTkQW7uMfOFzBJ3y3PgkinHGed5FjM4zOXjddlgsED4h7VXO
         XKiQ==
X-Forwarded-Encrypted: i=1; AKwUvByA4Tbec5h0nDJKiAp4YJ5wheBgNQ9F5mc9Fl4yFlQUdl1QrJTGueIx/mTCvGAm6B2mgTjoYcc=@lists.linux.dev
X-Gm-Message-State: AFuF++n0IeXkv/H7jIDvlVCyEZ/PBYgSY2c3SbeKa9NtrZobj+d/VYzu
	9r9Xl22K23ClMyz/63VDyjowGwhTADyKeR+h2AW3kXCCqMNXBDpBCZC1mMoB4JVuQok=
X-Gm-Gg: AYBFou3Qb1Jx4gKaQ708vEnobzrzGzL/50Fvuq/SLSyo0razECZg1gvb4nomJ6HPn/G
	zPBxf836HKuimpefKQIfh+yloSM8t3MM92TvYLw5nEYSp6hEUWmrXJNrwPLobsIgnq9N7d5N8el
	HqKsJYOMYonTNqf9boc6/qk+ImC36LOkYd413pw3nQCR4AlxJ/huxKzbye3irgdywhfaBDa6AnV
	6jG1hY6DhFlRIf59V14fPVKD/Fa70PwDIxri3g6G1t9hgwKQ6SfT9p4YWQ4+VCu7/Y+4ogi/4JY
	THu32MxUJiC1SJZ4bnF/vu9Bx6BVv7lBDRaqQyvgpY8/aykq8PewZFW6Re0oiLBOiipH+PM0h3y
	zX+9YFfFhihU1ml5gPC6m6ymC9Rh6jWPbDVeu9nplEvMQyug5omYt83o2CgXD+c5WHFpNUs+1Ck
	qsnzIS9RbeY8VeBtEIcnUI79A+mis+UBibfkRgAhjlIDSdGpDbAU8zkLLYRIoUMNxWGtvP6QjpV
	OX+dNPVnfs15PD6W7FL
X-Received: by 2002:a05:600c:46cd:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4a16992fb89mr118380335e9.1.1791211193895;
        Mon, 05 Oct 2026 07:39:53 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a03ff20831sm219706445e9.4.2026.10.05.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:53 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/6] net: bridge: fwd optimization cleanups
Date: Mon,  5 Oct 2026 17:39:31 +0300
Message-ID: <20261005143937.877466-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch-set takes care of the review comments and also does some
additional cleanups after the recent forwarding optimizations. The first
patch and the fourth take care of Ido's comments[1]. I have folded his
suggestion with inlining the pvid helpers which aren't necessary anymore.
The second patch takes care of Sashiko's comment[2]. The rest are
additional cleanups. No functional changes intended by any of these.
For more information please check their commit messages.

I do have one more separate patch-set which removes more VLAN lookups,
this one is only about following up on comments and minor cleanups.

[1] https://lore.kernel.org/netdev/20260921134458.GA2199421@shredder/
[2] https://lore.kernel.org/netdev/179085595018.434549.16034696945314071975@kernel.org/

Thanks,
 Nik

Nikolay Aleksandrov (6):
  net: bridge: rename dst to fwd in br_flood_vlan
  net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
  net: bridge: vlan: share VLAN validation in br_should_learn
  net: bridge: vlan: inline pvid pointer updates
  net: bridge: fdb: factor out configured entry destination updates
  net: bridge: fdb: use the entry key in __fdb_update

 net/bridge/br_fdb.c     | 51 ++++++++++++++++++++++------------------
 net/bridge/br_forward.c | 14 +++++------
 net/bridge/br_vlan.c    | 52 +++++++++++++----------------------------
 3 files changed, 51 insertions(+), 66 deletions(-)

-- 
2.47.3

