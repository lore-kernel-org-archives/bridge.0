Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=R7mUX90l8o0S9+V/fEV1ZGChu1NSu+7kE2KVhqAX+XM=;
	b=MkqSLcimGKgvrM+ba1MYM7OCLo59R9IEXr16UfQ74/c0huhZwEVXeWfSYIjYUMQXWI
	s4mPqfQYbPs37WNCllDoZQEJ3AO6KYpdGMv3k6saYIAZykQheNl+/H75Fu5ub/PBEj1m
	rHM+5hrQVxhGvyWCLSdi/W5uy+yur2oaJwtx6nGrf06xjfuW4s01t801xQC9RzYS5wOg
	3eN8VE4bAMSDcX19gpKZmgjGi8wBkuNtyZDSHA2tfCdidjmhiLKP0zmP0v8QYeipIAM7
	jtOLCy3b4F1PxRMGWyyE9Rtdr5IGecSadUs2mjJvd0MkAvZ6hYyv1a62uv7Z5cw56wjZ
	ulKQ==
MIME-Version: 1.0
In-Reply-To: <1359748930-31475-6-git-send-email-vyasevic@redhat.com>
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-6-git-send-email-vyasevic@redhat.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 2 Feb 2013 02:04:14 +0100
Message-ID: <CAHXqBFKXEHjghyDe4UQs4inH55UzWcsz+eWAXR4qFiM7+4yVxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v9 net-next 05/12] bridge: Add the ability to
	configure pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
> A user may designate a certain vlan as PVID.  This means that
> any ingress frame that does not contain a vlan tag is assigned to
> this vlan and any forwarding decisions are made with this vlan in mind.
[...]
>  struct net_port_vlans {
>         u16                             port_idx;
> +       u16                             pvid;

I'm confused about the implementation. I would expect pvid field in
net_bridge_port and adding a tag if it isn't there on ingress path.
The rest would be just like without PVIDs. But here you pvid field to
net_port_vlans, and don't do anything with it in receive nor transmit
path. Does it work? What am I missing?

Best Regards,
Micha=C5=82 Miros=C5=82aw
