Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vpEZx2aDaRD4hwz/cgEGHsBbudveBVKpDQc3oNrzJIc=;
 b=A1mUx61Urxs2tc3tDNhFy5T2KYzXThskLrNm4DZWlKBPDM1U1/UpjS3L5MCLg7Nwp0
 lruhQU7oJCghLyzpYkjK7jdMiWwSWztmQCbknVuOk1DFg94SmfPNWpwfsExjOy/+8Vt2
 MaMwlHLqPHn1YWbEMte4iUQ8Yfewa66RLkgp82QG3HJN5HRJDSV3Effiw9CKp9UWNc1z
 ux7bPK+bV8P8z1E/scBFoGuZT3y/GCGzIP9ULqrTl/JNZ69tR/PyHRlu4yQ3e+Rm7qSp
 Wyb552MCBAUv/yNsVjtNq7jOSEXvcY+mKjUYPm3iP7AYBZbFP8puo7690NMGVYyUi97N
 p8aA==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YgEkXARS160I9Ooe@lunn.ch>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
 <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
 <YgD5MglBy/UbN0uX@shredder> <YgEkXARS160I9Ooe@lunn.ch>
Date: Tue, 08 Feb 2022 10:06:43 +0100
Message-ID: <867da5viak.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On m=C3=A5n, feb 07, 2022 at 14:53, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +	if (p->flags & BR_PORT_LOCKED) {
>> > +		fdb_entry =3D br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
>> > +		if (!(fdb_entry && fdb_entry->dst =3D=3D p))
>> > +			goto drop;
>>=20
>> I'm not familiar with 802.1X so I have some questions:
>
> Me neither.
>
>>=20
>> 1. Do we need to differentiate between no FDB entry and an FDB entry
>> pointing to a different port than we expect?
>
> And extending that question, a static vs a dynamic entry?
>
>     Andrew

The question is - if there is an fdb entry or not - for the specific client
mac address behind the locked port in the bridge associated with the
respective locked port and vlan taken into consideration.
Normally you would have learning disabled, or from a fresh start if a port
is locked, it will not learn on incoming from that port, so you need to
add the fdb entry from user-space. In the common case you will want to
use static entries and remember the master flag for the entry to go to
the bridge module.
