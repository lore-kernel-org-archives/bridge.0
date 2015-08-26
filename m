Return-Path: <marichika4@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=xYjrdIfYqnypJ5IK/OpNMslVoE6CyDeBEh2w8LN01OQ=;
	b=WDV3LgcyaKJA10yDsVkZkIBN3PBcehbNVOoJ/yS6fCILslja+ZFEwIeK0G2A+yKO8u
	Kt72fpYW5RTlCkFgXi9UMFUMakV7yP0uPNzwvjsNQdtYtJpbIAt/hrDgIHZEFaXqIu/K
	WpMgEcr6C8mkwColfq8Nw6pswsz0ldIXkC39Bq/ADo6z+tlLltiUIsoKtbCQDrQq3Fpn
	mHEzv3xpjf8TVxk9eB7YkzZ6p/FeeNUyB/0KfdZ+2iZ6ZpCFEVGHiaNR/n1uk9knRbuy
	vKjm5PxPYdzvlG7kVWSYI/JlmCejkc0CXxMnCNtlrI+HYnb4+hGjEjYBVaVUWNn5XZzf
	7j0g==
MIME-Version: 1.0
In-Reply-To: <E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>
	<20150825.194222.390859854071446877.davem@davemloft.net>
	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
Date: Wed, 26 Aug 2015 11:40:27 +0530
Message-ID: <CAN+pFwJKFeQJw_4mPEH5_WmHdBUn75FL+-Cq=YaR+FR-+cRfEw@mail.gmail.com>
From: B Viswanath <marichika4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v2] bridge: vlan: allow to suppress
 local mac install for all vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: "vyasevic@redhat.com" <vyasevic@redhat.com>, bridge@lists.linux-foundation.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, wkok@cumulusnetworks.com, David Miller <davem@davemloft.net>

>>
>> I'd rather we fix the essence of the scalability problem than add
>> more spaghetti code to the various bridge paths.
>>
>> Can we make the fdb entries smaller?
>>
>> Can we enhance how we store such local entries such that they live in
>> a compact datastructure?  Perhaps the FDB can consist of a very dense
>> lookup mechanism for local stuff sitting alongside the current table.
>
> Certainly, that should be done and I will look into it, but the essence o=
f this patch
> is a bit different. The problem here is not the size of the fdb entries, =
it=E2=80=99s more the
> number of them - having 96000 entries (even if they were 1 byte ones) is =
just way
> too much especially when the fdb hash size is small and static. We could =
work on making
> it dynamic though, but still these type of local entries per vlan per por=
t can easily be avoided
> with this option.
>

I was wondering if it is possible to assign a vlan bitmap for the FDB
entry, instead of replicating the entry for each vlan. ( I believe
Roopa has done something similar, but not so sure). This means that
the number of FDB entries remain static for any number of vlans.

I guess its more complicated than it sounds, but just wanted to know
if its feasible at all.

Thanks
Vissu

>
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
