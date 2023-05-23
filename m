Return-Path: <pabeni@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 321D560B05
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29BE5605BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684832675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mh8toiKSONJxpueXVbWPsMK7oHcXlzbD/7oSSgzRjtc=;
 b=Atg44yxELlFgetfXQf95q+h/8jVZlZtgwu8+xOtUWVJxZv0e6oKv5JREG9yH1JUtq+dZUR
 xOg/Kzx/P3r5IZQXG1R538qOa9HBZn89I3EuRIYXy7l5Xsv4YCeYT6JVlPKdICSN7PoyfR
 cK0sc6DgiKxeWlivt5ejpgIf4+X2erU=
Message-ID: <de69794bc23a7a019136134cee1e819937f0777a.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 23 May 2023 11:04:27 +0200
In-Reply-To: <ZGx0/hwPmFFN2ivS@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder> <20230519145218.659b0104@kernel.org>
 <ZGx0/hwPmFFN2ivS@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
	indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, razor@blackwall.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, xiyou.wangcong@gmail.com, saeedm@nvidia.com, davem@davemloft.net

On Tue, 2023-05-23 at 11:10 +0300, Ido Schimmel wrote:
> On Fri, May 19, 2023 at 02:52:18PM -0700, Jakub Kicinski wrote:
> > On Fri, 19 May 2023 16:51:48 +0300 Ido Schimmel wrote:
> > > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > > index fc17b9fd93e6..274e55455b15 100644
> > > --- a/net/bridge/br_input.c
> > > +++ b/net/bridge/br_input.c
> > > @@ -46,6 +46,8 @@ static int br_pass_frame_up(struct sk_buff *skb)
> > >          */
> > >         br_switchdev_frame_unmark(skb);
> > > =20
> > > +       skb->l2_miss =3D BR_INPUT_SKB_CB(skb)->miss;
> > > +
> > >         /* Bridge is just like any other port.  Make sure the
> > >          * packet is allowed except in promisc mode when someone
> > >          * may be running packet capture.
> > >=20
> > > Ran these changes through the selftest and it seems to work.
> >=20
> > Can we possibly put the new field at the end of the CB and then have TC
> > look at it in the CB? We already do a bit of such CB juggling in strp
> > (first member of struct sk_skb_cb).
>=20
> Using the CB between different layers is very fragile and I would like
> to avoid it. Note that the skb can pass various layers until hitting the
> classifier, each of which can decide to memset() the CB.
>=20
> Anyway, I think I have a better alternative. I added the 'l2_miss' bit
> to the tc skb extension and adjusted the bridge to mark packets via this
> extension. The entire thing is protected by the existing 'tc_skb_ext_tc'
> static key, so overhead is kept to a minimum when feature is disabled.
> Extended flower to enable / disable this key when filters that match on
> 'l2_miss' are added / removed.
>=20
> bridge change to mark the packet:
> https://github.com/idosch/linux/commit/3fab206492fcad9177f2340680f02ced1b=
9a0dec.patch
>=20
> flow_dissector change to dissect the info from the extension:
> https://github.com/idosch/linux/commit/1533c078b02586547817a4e63989a0db62=
aa5315.patch
>=20
> flower change to enable / disable the key:
> https://github.com/idosch/linux/commit/cf84b277511ec80fe565c41271abc6b2e2=
f629af.patch
>=20
> Advantages compared to the previous approach are that we do not need a
> new bit in the skb and that overhead is kept to a minimum when feature
> is disabled. Disadvantage is that overhead is higher when feature is
> enabled.
>=20
> WDYT?

Looks good to me.

I think you would only need to set/add the extension when l2_miss is
true, right? (with no extension l2 hit is assumed). That will avoid
unneeded overhead for br_dev_xmit().

All the others involved paths look like slow(er) one, so the occasional
skb extension overhead should not be a problem.

Cheers,

Paolo

