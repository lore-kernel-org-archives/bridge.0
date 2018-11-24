Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=R5Y7/VowfSHpGe8aSZS7F61N5XW7uPRIIMx+auV8rs0=;
	b=TcelOPvPdmr5XbrJ5sO5uOlh9dY45V5XxoZGMyMxIS1iqkUWjrMJjD2pBv64wzk6xB
	FEx78sQRpmKlV28VlsKHyetwHCi4rzlwj0YhKVFc/dOVHKIK58D/YazwYi6P9Yyo39mn
	vvMUIgt+qWOCjJD8LvEyVHGpbQJL6jWM1C32M=
Date: Sat, 24 Nov 2018 18:46:27 +0200
In-Reply-To: <20181124162541.GC24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
	<66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
	<20181124162541.GC24681@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <98A5C526-DBF7-40F0-9CB0-1C7AF7A5CF32@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next v2 1/3] net: bridge: add support for
	user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 24 November 2018 18:25:41 EET, Andrew Lunn <andrew@lunn=2Ech> wrote:
>On Sat, Nov 24, 2018 at 06:18:33PM +0200, nikolay@cumulusnetworks=2Ecom
>wrote:
>> On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn=2Ech> wrote:
>> >> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id
>opt,
>> >bool on,
>> >> +		      struct netlink_ext_ack *extack)
>> >> +{
>> >> +	switch (opt) {
>> >> +	default:
>> >> +		/* shouldn't be called with unsupported options */
>> >> +		WARN_ON(1);
>> >> +		break;
>> >
>> >So you return 0 here, meaning the br_debug() lower down will not
>> >happen=2E Maybe return -EOPNOTSUPP?
>> >
>>=20
>> No, the idea here is that some option in the future might return an
>error=2E=20
>> This function cannot be called with unsupported option thus the warn=2E
>
>
>O=2EK, i was trying to make it easier to see which option caused it to
>happen=2E
>
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >
>> >> +int br_boolopt_multi_toggle(struct net_bridge *br,
>> >> +			    struct br_boolopt_multi *bm,
>> >> +			    struct netlink_ext_ack *extack)
>> >> +{
>> >> +	unsigned long bitmap =3D bm->optmask;
>> >> +	int err =3D 0;
>> >> +	int opt_id;
>> >> +
>> >> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>> >> +		bool on =3D !!(bm->optval & BIT(opt_id));
>> >> +
>> >> +		err =3D br_boolopt_toggle(br, opt_id, on, extack);
>> >> +		if (err) {
>> >> +			br_debug(br, "boolopt multi-toggle error: option: %d current:
>%d
>> >new: %d error: %d\n",
>> >> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
>> >> +			break;
>> >> +		}
>> >> +	}
>> >
>> >Does the semantics of extack allow you to return something even when
>> >there is no error? If there are bits > BR_BOOLOPT_MAX you could
>return
>> >0, but also add a warning in extack that some bits where not
>supported
>> >by this kernel=2E
>>=20
>> If we return 0 there's no reason to check extack=2E=20
>
>Well, the caller can check to see if extack is present, even on
>success=2E This is extack, not extnack after all=2E=2E=2E
>

Evenif it's possible to return it without an error (I need to confirm that=
), the real problem is extack doesn't support
format strings, i=2E e=2E we can't say which bit is missing which makes it=
 useless in this case IMO=2E=20

>	 Andrew

