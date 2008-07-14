Message-ID: <487B1FF6.1030300@iki.fi>
Date: Mon, 14 Jul 2008 12:44:22 +0300
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <timo.teras@iki.fi>
MIME-Version: 1.0
References: <4876FDF0.1030807@iki.fi> <487AA0CD.9090600@snapgear.com>
	<487AFF82.4090707@iki.fi> <487B11D9.7090800@snapgear.com>
In-Reply-To: <487B11D9.7090800@snapgear.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: =?UTF-8?B?VGltbyBUZXLDpHM=?= <timo.teras@gmail.com>
Subject: Re: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Craig <philipc@snapgear.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Philip Craig wrote:
> Timo Ter=E4s wrote:
>> There is an essential difference in this patch compared to the one
>> I referred to. This patch adds a new way to create GRE devices which
>> results in ethernet style device whereas the older patch modifies
>> transmit and receive paths to detect packets coming from bridging
>> code and does not need userland changes at all.
>>
>> I kind of like the fact that userland tools work as-is and that
>> I don't need any special flags for the GRE tunnel creation. However
>> your patch does look way cleaner.
>>
>> Any comments on what the solution to merged in should look like?
>=20
> I posted a cleaner version that's similar to what the old patch
> did, see http://marc.info/?l=3Dlinux-netdev&m=3D115449948503549&w=3D2

That's a third way to do it. The patch I referred to changed
ip_gre mostly (only change to bridging was the device type check).

But it has the same limitation that ether encapsulation is only
usable in association with bridging.

> But I don't think that is the right approach:
> - it forces you to use bridging if you only want ethernet over GRE
> - the change fundamentally has nothing to do with bridging

Yes, I would not do the ethernet header stuff in bridging code
either.

> Actually, this change doesn't really belong in GRE either, because
> that forces you to choose between ethernet encapsulation and not.
> It could be a new device that sits on top of GRE and simply does
> ethernet encapsulation then passes it to the raw GRE device.
> That's a lot of infrastructure for something so simple though,
> and I don't think people will want to use both devices at once.

This sounds as the most robust way to do it. But yes, it sounds
unlikely that both devices would be used simultaneously.

Not sure how easy it would be to add a new tunnel type. Apparently
they use IPPROTO_* to differentiate type and it would be the same
in this case.

Thanks for the feedback so far.
- Timo
