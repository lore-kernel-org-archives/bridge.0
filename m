Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887000;
	b=NcC8LixmbtZy3xsQu4Xgpa0eN8WzcOXUjZFk/gw3QuAIomqkW0R+PCgvXP1bxvtRetsP
	 Xy7HoymexktdGcC27q5+jvROtr8IHROp3Ju/AUBdEfgwVqqEYEyV2ZGjP3qlURP3zLHPL
	 ispr6jLxuqZ1AGBKlMbKUPkMi4HbdhspHAkaIQL3C5z6ZijXMVAzmTHbE8nuaUNbI1Saj
	 avC9AHqUTXM/U0vVbcxgNyh9fOYiODjAbKug2FkRtH4SIAgT+PZkgTXnrThZhtfR/pBnZ
	 7LEqI2iT2VNRP3x5oFcgG2JNHcq7FYSl/KlbTi8IYus5pd/AKbyshezCItmnrOfIYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887000;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5de7j5buijetKe9mhmqKAeLcHieeqVgYr8IfmGSIxhM=;
	b=MIlrAElz/q4/BMxfB/UvdO8qi8IF9rXa4KivXeW8pkVjDIE4esRsfE3FOzYhb//sXsQ0
	 DVtKS7vdvLWMbKLGkg2sP2zNyHezQP33UJu1MdOqK3EF0cYsLIbtMky3DMwdgPlSLp9dl
	 v7HC/ZFaUIKqiQgCbg4NGOjxwEbRDvV+8qpO94b2UEVPHeZIVDpKiLATkdo39MmLqMkOl
	 S5vjw5wcIlNjUFcQ2rbGRqIPKNjfpOJB4D5p7qofUlheZuWLuGcHGW4a+ShGfIF4gQowV
	 jN+2hL3Z55Di5CUeGa+gYcwHNe/Y5LNr5WlzeUKM4OciUFyN87ALN+dgmPxCbHJgMPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Kemm3CLw;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA89606A331
	for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 03:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA89606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Kemm3CLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Kemm3CLwCcIKAD933FqXmrDxKMbH2+HVT/bov0HfMmyUNHWO8PP0IiZIaP8iJWrv12oUwv92jmRl4
	 gmuKXl1ZtCsW/4OsVql59F3pZX7IRMTOp7Vy7DMPo6mKvYnKy3Wp6W6wiRiHwIm3+wwUyWkl055dL1
	 TCjAC2P6t0RWcScI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66afbcd5498a-d1a27;
	Tue, 17 Nov 2026 11:43:16 +0800 (CST)
X-RM-TRANSID:2ee66afbcd5498a-d1a27
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.50] (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76afbcd527b8-a1a99;
	Tue, 17 Nov 2026 11:43:16 +0800 (CST)
X-RM-TRANSID:2ee76afbcd527b8-a1a99
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Daniel Wade <danjwade95@gmail.com>, netdev@vger.kernel.org
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org, yana06070@163.com
Subject:
 Re: [PATCH net] net: bridge: fix skb leak of reinjected link-local frames
Date: Tue, 17 Nov 2026 11:43:15 +0800
Message-ID: <1794886995000.600537.2725044486872632095@cmss.chinamobile.com>
In-Reply-To: <20261115130211.7724-1-danjwade95@gmail.com>
References: <20261115130211.7724-1-danjwade95@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On 11/15/26 23:32, Daniel Wade wrote:
> br_handle_frame() passes the link-local frames it neither forwards nor
> delivers (01:80:c2:00:00:02 to 0d and 0f, unless set in the group
> forward mask) through NF_HOOK() at NF_BR_LOCAL_IN. Since commit
> 3b2e2904deb3 ("net: bridge: fix per-port af_packet sockets") the okfn
> only learns the source and returns 1, which becomes RX_HANDLER_PASS.

Before that commit the okfn called br_pass_frame_up() and the frame
was consumed on reinjection. The leak starts at 3b2e2904deb3.

The queue paths hold up too. Both fail-open exits in
__nfqnl_enqueue_packet() reinject NF_ACCEPT inside the enqueue call,
and nf_queue() still reports the frame as queued. nf_hook() returns
0, br_handle_frame() answers RX_HANDLER_CONSUMED, and the single free
is the kfree_skb() in the new okfn. QUEUE_BYPASS just resumes the
hook walk. If the remaining hooks accept, nf_hook() returns 1 and the
frame is passed up from br_handle_frame() itself. The branch now
matches the 0x00 and 0x0e cases above it, including the *pskb
assignment after skb_share_check().

No other bridge okfn leaves the skb with the caller. Delivered frames
reach netif_receive_skb() through br_pass_frame_up() and forwarding
goes through br_forward_finish(). The link-local hook was the
exception.

Reviewed-by: Xia Yan <yanxia@cmss.chinamobile.com>


