Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADD3E3162;
	Tue, 10 Mar 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172722; cv=none; b=kjdtWblmLXqcZNfoCB+ydux4OfTFp9SUeRBpFeMiW+yupaxDw/9IJFQLsuE0TEUMfaDEqGf07t+xZllIEagI5LS6KTWZoe1YaFUf7wxXsOQnk/6YoH9GyZqBeGrhIkeEfUBgSLAmOndJC2IwV13KVtyknMTLzomcH5JCjgmvbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172722; c=relaxed/simple;
	bh=Je1rIPnGOjOPK0cgnGXu5ko559F90dtD+GO7ltgNRNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ct4+3ul1WUPikn3jjlplYStH/CzDkXIidpAn4TgYSKd8VV2ht7it0hDovjv66rY7HrgzGyPt3cOXA5NySC4HWjPQ4yYS8pH5jMLlWTg5jsNfO1TX5d+VRzW3K6b2YB3OsR1qybLDj5HXWZCoNXrEd4qDtUNAeIQU2HWTjytLHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p8+exbOP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qijL2WGo; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p8+exbOP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qijL2WGo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 6A2A21380B72;
	Tue, 10 Mar 2026 15:58:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 15:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773172720;
	 x=1773179920; bh=uJKac+q963i+BI7ifqs+uvHGeqpQW5n8cXoM0XhfjDE=; b=
	p8+exbOPtg07MY+R3EnFNA20Kkr3N2QjsLGxGKYCUaFeUU+zYkehFD05oRlzBbP0
	zoeJBXUF3kwo841D9zNFkSIAII+yULHdiaQD839sRQ7YppC/9uRDsXErZTjlwJkf
	Euac/cFiN4VSWj0x6hhVCir9vVFWlE4rZCztH8j/pN0I4Utx/DWy0HCMrbjemXsq
	lB6JbTICF0ymGVCEnURfGJ7emZiNw5JM/xj9ruhaez4T4pG4j7ioyqvvDzNVFlQD
	j7ILPXSuJ0eChWXEvf4pugti0EBvA0XRs5EZk7T+M5fFLLGfPmgW1HPPSNqbkeIC
	WPV717hJKRCfHKDIZHkK/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773172720; x=
	1773179920; bh=uJKac+q963i+BI7ifqs+uvHGeqpQW5n8cXoM0XhfjDE=; b=q
	ijL2WGosfVCk4yS/2ZJP+KcDkeUfhFoNzavwkTr8FWfNLS3KX5+APlEOLZXj8wKF
	Be7MjtCNKFZ9ZsKLPFRL0dtBGrxjCOzgYhoS1Zyqwt72BJKKgv6vPjwUCiQd38Uu
	zLZ/mf/N4pqkALQ51u+/WO1y50frnmAlhgUsv8MN8n8QJ7T3hSL2vyPU3lzpPdRt
	BwQOGEbjJ0SHtjpoZlynclFf8rD/z0LtL+tfXU3RVVWQFkIrYqz/ZRcEUAR164zN
	WKFtCwR5lrze0+mBkbqoft+Bk2krz0vP0pB9U3dlPUFN1RnXgEfeZorpUd01LFlK
	JoEhHU92w9im6Ewrpwljg==
X-ME-Sender: <xms:7Hewadd_u-_5IyplfirBN4sVaJUUu_qe0AzGHW505ziCjx6iHw4-VA>
    <xme:7HewaWBsc6_7Pxq88lpJkUxp5g2bzea6mZ_IHYvvWs_hxP_y6Ji2BLJIBJ7RRZV8R
    k4aY0e5LRXlgJi5sqanFu7WIiTJa5E-wH_FRUDzObFZdpOiJVmt2y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7HewaTptfnnDEvrdjU_KPgRR98biY5NyU53QsEHRoAbbaDgxHulRNA>
    <xmx:7Hewae65yMlk6TZE793cikNMpLxu3sezdwdKpGvHJwc_UG7YGoVvBg>
    <xmx:7HewaYoCs48n6QmndVqPVvsI9rf1Qzp57oH4o5CXLNePan4mibXDIg>
    <xmx:7HewadEhKVk-KVm4HYUh-0U64JKCQU_3e1hBRQpiA1JzeYy43o0vpQ>
    <xmx:8HewaWh3BW8aWcheDPCA5kVm90RvJg4zha6DdtP7NYH_KBDbjfsyjwPm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C056E700069; Tue, 10 Mar 2026 15:58:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Aes-ty0OVaaR
Date: Tue, 10 Mar 2026 20:58:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Fernando Fernandez Mancera" <fmancera@suse.de>,
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
Message-Id: <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
In-Reply-To: <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
 <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only and
 clean up Kconfigs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026, at 20:40, Kolbj=C3=B8rn Barmen wrote:
> On Mon, 9 Mar 2026, Krzysztof Kozlowski wrote:
>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>
>> It must stay module for me. Alternatively, drop it, but then some use=
rs
>> will be really affected.
>
> I agree. If anything I would prefer to see IPv4 be made optional (and
> modular) as well, and not as something IPv6 depends on, it's (AFAIK)
> impossible today to build an IPv6-only Linux kernel.=20

My first feeling was that this is a bad idea as well. On the other hand
I found that the default changed from =3Dm to -y over 10 years ago, all
recent distros listed in https://github.com/nyrahul/linux-kernel-configs
use that default (the only two exceptions are board specific builds
of Debian and Ubuntu for linux-5.x).

The list does not include openwrt though, and I know that in
previous releases, there was an optional kmod-ipv6 package
that could be left out of an install without rebuilding
the kernel. Configurations under 128MB are only partially
supported there these days, so maybe it's no longer important
for openwrt either, but it would be good to get a confirmation
from someone doing the packaging.

For optional IPv4 support, I would expect that it's possible
to make it a loadable module, with a significant amount of
work and little benefit. Loading an ipv6 module without also
loading ipv4 sounds completely unrealistic though, given
the way the code is structured today.

    Arnd
