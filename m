Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=Fea0XL3AN/K7EqLpzpiIhBhs+wGzRR+0+ODVJeWVrVE=;
	b=dRcetJxadJuBv7FA/qAtEvsSLNcdL/yePLBE4bjy0REcfxACdPmTr+DoiqrblhbGGx
	4MHpLJcjdpm5vcVnvUe+wSoBWLv076j/OjycWIedUz5ZGLRB6EQEJHCk85cZbW/XQoqg
	sb/Mu5pGpFCR1V4ypZaEGqzul/aONqzt0Ve1Q=
Date: Sat, 24 Nov 2018 18:18:33 +0200
In-Reply-To: <20181124161041.GA24681@lunn.ch>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
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

On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn=2Ech> wrote:
>> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt,
>bool on,
>> +		      struct netlink_ext_ack *extack)
>> +{
>> +	switch (opt) {
>> +	default:
>> +		/* shouldn't be called with unsupported options */
>> +		WARN_ON(1);
>> +		break;
>
>So you return 0 here, meaning the br_debug() lower down will not
>happen=2E Maybe return -EOPNOTSUPP?
>

No, the idea here is that some option in the future might return an error=
=2E=20
This function cannot be called with unsupported option thus the warn=2E=20

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
>> +int br_boolopt_multi_toggle(struct net_bridge *br,
>> +			    struct br_boolopt_multi *bm,
>> +			    struct netlink_ext_ack *extack)
>> +{
>> +	unsigned long bitmap =3D bm->optmask;
>> +	int err =3D 0;
>> +	int opt_id;
>> +
>> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>> +		bool on =3D !!(bm->optval & BIT(opt_id));
>> +
>> +		err =3D br_boolopt_toggle(br, opt_id, on, extack);
>> +		if (err) {
>> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d
>new: %d error: %d\n",
>> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
>> +			break;
>> +		}
>> +	}
>
>Does the semantics of extack allow you to return something even when
>there is no error? If there are bits > BR_BOOLOPT_MAX you could return
>0, but also add a warning in extack that some bits where not supported
>by this kernel=2E

If we return 0 there's no reason to check extack=2E=20

>> +void br_boolopt_multi_get(const struct net_bridge *br,
>> +			  struct br_boolopt_multi *bm)
>> +{
>> +	u32 optval =3D 0;
>> +	int opt_id;
>> +
>> +	for (opt_id =3D 0; opt_id < BR_BOOLOPT_MAX; opt_id++)
>> +		optval |=3D (br_boolopt_get(br, opt_id) << opt_id);
>> +
>> +	bm->optval =3D optval;
>> +	bm->optmask =3D 0;
>
>You liked the idea of setting optmask to indicate which bits this
>kernel supports=2E Did you change your mind?
>

Please see patch 03=2E

>       Andrew


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
