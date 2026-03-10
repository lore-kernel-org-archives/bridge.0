Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381C39DBD8;
	Tue, 10 Mar 2026 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181148; cv=none; b=Ec5ysc8oubxptZId8MunknKSgSz/5iwaNSlbkhOt4SEjiEfLQmRcXu/BqJYzh5IoNKMYk4r4oabddV6n5QmJotCs16G27h1xy/0X0KfiOJjAo4SrGd4r8UmakSJwd2uqGV+wHqw04VIrMQv1jsJomKvMswVyflGcLKWJNIjo0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181148; c=relaxed/simple;
	bh=iJDAvNQWfTXa/d54rND70rOy1C42f+AfmZ9GTZCuIqQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dvYTdTKCaLr0UtWvM9ad+HLmV1nsfAo/7xq4tuAvZxw+VOg+vrjd0hek8zn4nayCKHbKECHcxp4RGcuzrH9HWsdq/eUKtsJL7zakuETHKCZvs++F4lMQ5q3XDUTgZ8kHEFpT1ZCBy/vdcSDtvcwf6rSNgpyw82XVrWqUx5sC6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VqmquK1T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsZydKiE; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VqmquK1T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsZydKiE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 4653D1380E3E;
	Tue, 10 Mar 2026 18:19:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 18:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773181146;
	 x=1773188346; bh=FRlgnoZcWgoJlJFqsFQjQT0OGLiik2V/K6MtiEBUEM4=; b=
	VqmquK1ThYfiJInFZEGG+39y5whxw59dS6wZmFtow//LgI9y/NonddGjeQwmPZ/2
	azkFcT32OrNx1XyiDOr0SaQ1c3nit329uNzohSK04kAbuPfUBFvs+u/RDGluQCOH
	jqpYR+ziRqTTdRVWSVQRO+ZlgzGsbmNV1TT/a1fbaV2Kk1hzz+wOSMHlSX99KO5g
	liDb7rlA8TUDTa7QMbvEsO4wdGf4PMFZaqaAKvaTijErp7qSZF5me0X3/l3J+bQ3
	JFgCWwMhYW/RPNGyxTYOY0k8Cx6hAY7usxxd1NlF6i6cmqwPssqQEma3m8r81vJt
	NNjYJykU0bjy7dNr3b7bPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773181146; x=
	1773188346; bh=FRlgnoZcWgoJlJFqsFQjQT0OGLiik2V/K6MtiEBUEM4=; b=Y
	sZydKiERyzUc1fHk/tl6Li6wEjARPsNPjW3is4FphQW2TdGFTZh2K8cBgBSXgLJG
	SMh9tYz3F6k86gz7hSdCxRuRx5n52375jbcIsWultOywVWXVNWj9hT8IHPT1n2N9
	kXo6LkCsquMF36B2QwUmMTAoRt9FHOC6pYVGd6MzUaP/260NLveReE04O5UcNUuh
	e6mbnn6GYKv2thlc7Bda7TKmZh90RkYcEc1zqs06LZoCsFpQcjkWrLx7jWtfFwsk
	LDUHqtAjSb0+N4B8n921/cdjf5CvA3BSSSi0aVLaP/iYCLYeegalSoXaORHgPaBi
	HBTDeZNvX49NavL4DUsgA==
X-ME-Sender: <xms:15iwaRkDfzzHLp_X1kq4L_AU6-ituzyF3iSQa14ZIgckIpAikMqXfw>
    <xme:15iwaXqbd0PN-S2y7b3kkHufFY4ihJjA8BCVC5x5-YHDU5jqaRe6NflZmhtQFXKdn
    G9IhYD-tgpZBjo54RVlaMAsWUM6gf5AMCwjfFZoqGIzOjaROTos_uI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepteefudehvedutdeugfeuveffleduheehfeehffeujeduledvheeivdffleffjedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrghlrd
    hsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgtrdguihhonhhnvgesrghu
    rhhishhtohhrrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdroh
    hrghdprhgtphhtthhopehmrghrkhhushessghlohgthhhlrdguvgdprhgtphhtthhopehp
    rhgrsghhrghkrghrrdhmrghhrgguvghvqdhlrggurdhrjhessghprdhrvghnvghsrghsrd
    gtohhmpdhrtghpthhtohepsghhrghrghgrvhgrrdhmrghrrhgvugguhiessghrohgruggt
    ohhmrdgtohhmpdhrtghpthhtoheprhgrjhgrshhhvghkrghrrdhhuhguuhhmuhhlrgessg
    hrohgruggtohhmrdgtohhmpdhrtghpthhtohepshgvlhhvihhnrdigrghvihgvrhessghr
    ohgruggtohhmrdgtohhmpdhrtghpthhtohepvhhikhgrshdrghhuphhtrgessghrohgrug
    gtohhmrdgtohhm
X-ME-Proxy: <xmx:15iwaSyEiYKgC69cB5qy-uYRb8Nd3O_tBXiwXloun5USwoBjUG8xeA>
    <xmx:15iwafjqNp39TlpDsB0Ao61CEHQ-Vr8McIxINz19uDmPbtTumgvUrg>
    <xmx:15iwaczf5HZmVpoLxDtA2owqT7w2ViLLaS7j8VNYgxUfNRdi3v-vWA>
    <xmx:15iwaeuiBcsTfGR3tZRU2tKnnZXfCbonW_DF82rzFvkDf76wOt_Zvw>
    <xmx:2piwaSTzLKB4kDavqjxW2WNnXgJllxK2Ek5Rc5V4bVqgUqlvQa6tnmkj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 173C2700065; Tue, 10 Mar 2026 18:19:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Aes-ty0OVaaR
Date: Tue, 10 Mar 2026 23:18:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Selvin Xavier" <selvin.xavier@broadcom.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>, "Simon Horman" <horms@kernel.org>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 "maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <GR-QLogic-Storage-Upstream@marvell.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>, "Jon Maloy" <jmaloy@redhat.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Luca Weiss" <luca.weiss@fairphone.com>, "Sven Peter" <sven@kernel.org>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Gow" <david@davidgow.net>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Ryota Sakamoto" <sakamo.ryota@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Kir Chou" <note351@hotmail.com>, "Kuan-Wei Chiu" <visitorckw@gmail.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <linux-scsi@vger.kernel.org>,
 "open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
 "open list:NETFILTER" <coreteam@netfilter.org>,
 "open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>,
 "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Message-Id: <ebebb003-f7d7-4659-8248-9d36e9c2c26b@app.fastmail.com>
In-Reply-To: <87bjgvpenh.fsf@miraculix.mork.no>
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
 <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
 <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
 <87bjgvpenh.fsf@miraculix.mork.no>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only and
 clean up Kconfigs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026, at 22:18, Bj=C3=B8rn Mork wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>
>> The list does not include openwrt though, and I know that in
>> previous releases, there was an optional kmod-ipv6 package
>> that could be left out of an install without rebuilding
>> the kernel.
>
> The kmod-ipv6 package was dropped in 2016:
> https://github.com/openwrt/openwrt/commit/33beafa8d88e51907acba6fdece5=
a35f509934df
>
> And IPv6 was unconditionally enabled in OpenWrt in 2022:
> https://github.com/openwrt/openwrt/commit/832e7b817221d288df76b763ca12=
c585365db5d8

Thanks for checking!

Not sure what the commit log for the second one is trying to say, as
there generally was no build failure in mainline for a long time

But if nobody has bothered to revert the patch, it doesn't seem
to have caused any problems.

    Arnd
