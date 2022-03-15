Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=NExbxl+i2kuO3Pvzdgbe/Iig/umuCg0Aqp3WMWOTS
 DA=; b=bASI2gJC467wslZAh/G66t63jB1zY0shNB3Wuma/AJ/qKyNks5ywiEv9L
 TjeFFh+XXl3Xba8pswlacUlwKsgv6XjO4tuUavk/8KW8tuiClxHPA2BzZajqfTYu
 I/uZjMvH74mB/42xUXfqjI554e/RudCwZgpyiDh8kDwbjypE18L2y6YKTQmqJzjL
 7mTcc53No0wnYWnN+33WTsR38tuTr69ke7QiYaGaF7iFoR6rqY7RJTwLnaMFAzEU
 wbls6j+7Dt8oirYqY1Dbh6XhryFblkYZRiWcbtVCbeyEXYZsCO5bDI/c5Hr0/QTQ
 zcvbWWTTfSjlrGpd4XCbuUKtKKfRg==
Date: Tue, 15 Mar 2022 13:00:12 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YjBxvM+rYSMP8UNy@shredder>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <20220310142320.611738-2-schultz.hans+netdev@gmail.com>
 <Yi9fqkQ9wH3Duqhg@shredder> <86h77zha8b.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86h77zha8b.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 1/3] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Mar 15, 2022 at 09:48:52AM +0100, Hans Schultz wrote:
> On m=E5n, mar 14, 2022 at 17:30, Ido Schimmel <idosch@idosch.org> wrote:
> > On Thu, Mar 10, 2022 at 03:23:18PM +0100, Hans Schultz wrote:
> >> @@ -94,8 +95,16 @@ int br_handle_frame_finish(struct net *net, struct =
sock *sk, struct sk_buff *skb
> >>  			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
> >> =20
> >>  		if (!fdb_src || READ_ONCE(fdb_src->dst) !=3D p ||
> >> -		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> >> +		    test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
> >> +			if (!fdb_src) {
> >> +				set_bit(BR_FDB_ENTRY_LOCKED, &flags);
> >
> > This flag is read-only for user space, right? That is, the kernel needs
> > to reject it during netlink policy validation.
> >
>=20
> Yes, the flag is only readable from user space, unless there is a wish
> to change that.

OK, so please spell it out in the commit message so that it is clear the
flag can only be set by the kernel.
