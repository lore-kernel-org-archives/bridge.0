Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794272703;
	b=g4WdFi13sHe2c4WF+H2AFmqHSb7Dvznk+EWmHGUt6W1PXOzIFjHLbFhH7JTXMudls+OA
	 6Cs364TGnyHcGwDu44H3mL1vK8chHK+p09m5wajH64fMMDPDsfcpiyiG66KxgkaL/OK9l
	 vrbpYbXRAdwTiSqdIdb6UBupS1ShHFVw4d68CoO0lzx2IhZgvfpXSpx/Rbv8UxxItniFL
	 nBZghyII3Ug4pENHOrm+4ItAB4a4sieOPeBKOScmufGMPvBVwss6DniRtMaY5f0msvYKC
	 cLQ/oBnvksvKFxHE+XgAyhqam4wTyv3YXpzOAV4CI66/MxApVizKQewWbqIA+THU5mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272703;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=2yNEwyjlHqJdzN2rYHtxePRIGUY6zEHInx2Q7VBrP4k=;
	b=NUzhQEfBqSpH25ZyA1fRvZpigdJTawK80sGAAIaEL24C23eFuwUIu9KQtpjY7GYw7+cO
	 osGTFav8+25P9nPEr+h5d4SCeo9LQUhoxknFsW3gqF4ij7h1c0mtqyBd1cWqbyqd0ig78
	 N0ZskAIHt2Ts1cL9WlJN2hMXVK+ZpA+aI/3lkOjnudGu8Z4ZAVKjXTIFYUU1LnfC7ws+e
	 OZIOEWq6vvzdqQHcY5V/VhaDyjrwNRP1eUX3A77ZFBJE82sasxUs9OZua4eE7hyhyBDTQ
	 7Ww3G+ZmmaWYirud/05EBhely99GpuargLguM6IAuDnRcruak4HN2VPRnvaRe2FScWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=laveeshbansal.com;
	spf=pass smtp.mailfrom=laveeshbansal.com;
	dkim=pass header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=BV9wWXhv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.14
Received: from sender5-op-o14.zoho.com (sender5-op-o14.zoho.com [165.173.182.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897C606A321
	for <bridge@lists.linux.dev>; Tue, 10 Nov 2026 01:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B897C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=BV9wWXhv
ARC-Seal: i=1; a=rsa-sha256; t=1794272701; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P9AtOnRKOJ6acn081xxHPlZ0YqbuFZRhoodGJdrBm7+3VqDTsMHr5b+3Ie+n8YEOWHsQA/1AHAnRyRSTX/5UvUkGyhYN2+lph2B1MPIuxdxT1tEirX82ghYISGSSZp/lk65yEm5RyMGxkyaT37We9CpVeOuQjcRMBIDAfe4BhHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794272701; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2yNEwyjlHqJdzN2rYHtxePRIGUY6zEHInx2Q7VBrP4k=; 
	b=dPeH0c12LSXWHtXvT/e9JQYN4AuqKYg0353b7BFmDQcloYcgk8CJpABEAo6n9KWt2n+1fZyWvAne+a25D/gwmMAYOPopGghoyk/UVGQ0QtGm3ANSwCexNBLiOmU+4K5VcuvgT4ZwXz6oex4oJQ7Ufo8gDXRaRJZ7kbBTQBL44Mk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256; b=BV9wWXhvHRd8AEd8v500nKPCfMN5Kda7ob93BL6v7MWkrlmomIYJ/MNQrbtYuZL3OCUgWab1uhPQA9Tgf84gfLdFCL8LAp/fXUvHHSy8HknubRMIQBM3CSSIImdh6wGGcjXNXV1ejDZckKLJXQiTRSIz+3CBEGEZW/JWnD3CAfM=; c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1; bh=2yNEwyjlHqJdzN2rYHtxePRIGUY6zEHInx2Q7VBrP4k=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794272700085876.3702122985849;
	Mon, 9 Nov 2026 17:05:00 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+a8ba738fe2db6b4bb27f@syzkaller.appspotmail.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] netfilter: bridge: refragment packets with a vlan tag moved by the bridge
Date: Mon,  9 Nov 2026 17:04:50 -0800
Message-ID: <20261110010450.68995-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <avJo2nhgnulY776l@chamomile>
References: <avJo2nhgnulY776l@chamomile>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Tue, Nov 10, 2026 at 01:44:10AM +0100, Pablo Neira Ayuso wrote:
> Do you have a usecase for this?

I found this through the syzbot report and haven't seen a user report of
it. This is the follow-up for nf-next we discussed in
https://lore.kernel.org/r/atck-NoWvemxIsF6@chamomile.
