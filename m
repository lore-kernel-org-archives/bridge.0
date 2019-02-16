Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 16 Feb 2019 21:04:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550347450; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=vhANEB7gUA1vSAhqbKZ9klpwPxU2z6rc4An0vffHOik=;
	b=AaAaQCbikgGK1wXt6xndpFKUJYHUZAJvDkW5NFcxHgMz8wcBbUuHxQ7PnZc8gQDVMRFcjj
	ki57u7LUGAlFvuAjbZm+c+X86lrbAc1PoefGdqgumwDfhHTzeIS1asVMv9a0l6twbU/I64
	79UR5DKGsQcr7za5ktpqhmwdLht0gr06KEivOBJkVhaGX00Vxz9AktVnImlkb3OGFEZmm8
	YlTC8V2Hzn0MyYB65XACf2vlRacOuM279vPSMuYuIU+TrmisZiqSlabTfGeasaw5qQcdaz
	pD+I0dsGoJybpM4kqA/xy55XXh3N+26MneSf0l1CzohVZd8miJj94V2TbefYLw==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190216200405.GB25057@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190215171332.GA1472@otheros>
	<479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
	<733b151e-47dd-ad9a-b112-473cf551fbeb@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <733b151e-47dd-ad9a-b112-473cf551fbeb@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

Hi Nik, hi Ido,

By the way speaking about the IGMP/MLD querier mechanism. Not sure if
you are subscribed to the pim@ietf.org or mcast-wifi@ietf.org mailing lists.

There was a call for volunteers to progress IGMP/MLD to standards
track not that long ago:

"[pim] Volunteers needed for work on progressing IGMP/MLD on the standards track"
https://mailarchive.ietf.org/arch/msg/pim/F5y_w6jnrtzBpEiC7F_TxBv9PXI

I had voiced some concerns regarding the IGMPv2/MLDv1 report
suppression and the querier mechanism and their unfavourable
implications, as well as some issues (or ambiguities at least) with RFC4541:

https://mailarchive.ietf.org/arch/msg/pim/DWWYpnsZsbqHtafwYZ_swhDpbcQ
https://mailarchive.ietf.org/arch/msg/pim/omI4-pg-12vO88YuZcRP5TCz4wY


It seems that some bigger vendors had gathered for a phone call:

https://mailarchive.ietf.org/arch/msg/pim/jPAbf-PHgtgpwe8lgyjOzCHlhc0

But I haven't heard anything back from that meeting on those
lists.


Just wanted to forward this, in case you guys might maybe be
interested to participate there in some way. :-)

Cheers, Linus
