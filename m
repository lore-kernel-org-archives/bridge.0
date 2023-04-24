Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93AFD409A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31DE14098B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1682351999;
 x=1684943999; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kLDgafokn5x18GtTd+H6a14Z4DMxmnCa80D7PeLVP0=;
 b=uYkrKKyUtV1StUmdzNvBAn/Wjmql+OVygRxELaLbibhk0MBZtiaVnJeWhB87271I3+
 qY9m8UD87FWczYLHPvdmQbAyp1K88Mq1XrrxHRgjySCOmO3nCeV8G1DFbHXEEb9j7rg6
 hKcEh5ZXdyUAStZY7FFCGHvVfS48tDTpajhiWZR5QYoQrinybfucQmmfmGfu1gs+7x/i
 HVANjeACLCSHmEQ+D/T0a57DHZgge7NY4l8DFI9W0WjqyqgyBKPU5TENc4oCOfQs4mpx
 p2H5rj6lMIKdqRQ7Qahg879uj7wNWbj4immZh2CWDtZvlQ2JoRj1mu1PfvALlnCCxIEM
 ehfw==
Date: Mon, 24 Apr 2023 08:59:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230424085949.4bf52ac0@hermes.local>
In-Reply-To: <ZEakbR71vNuLnEFp@shredder>
References: <ZEZK9AkChoOF3Lys@Laptop-X1>
	<ZEakbR71vNuLnEFp@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

On Mon, 24 Apr 2023 18:46:53 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> On Mon, Apr 24, 2023 at 05:25:08PM +0800, Hangbin Liu wrote:
> > Hi,
> >=20
> > Maybe someone already has asked. The only official Linux bridge documen=
t I
> > got is a very ancient wiki page[1] or the ip link man page[2][3]. As th=
ere are
> > many bridge stp/vlan/multicast paramegers. Should we add a detailed ker=
nel
> > document about each parameter? The parameter showed in ip link page see=
ms
> > a little brief. =20
>=20
> I suggest improving the man pages instead of adding kernel
> documentation. The man pages are the most up to date resource and
> therefore the one users probably refer to the most. Also, it's already
> quite annoying to patch both "ip-link" and "bridge" man pages when
> adding bridge port options. Adding a third document and making sure all
> three resources are patched would be a nightmare...
>=20
> >=20
> > I'd like to help do this work. But apparently neither my English nor my
> > understanding of the code is good enough. Anyway, if you want, I can he=
lp
> > write a draft version first and you (bridge maintainers) keep working o=
n this. =20
>=20
> I can help reviewing man page patches if you want. I'm going to send
> some soon. Will copy you.
>=20
> >=20
> > [1] https://wiki.linuxfoundation.org/networking/bridge
> > [2] https://man7.org/linux/man-pages/man8/bridge.8.html
> > [3] https://man7.org/linux/man-pages/man8/ip-link.8.html
> >=20
> > Thanks
> > Hangbin =20

Yes, please update the iproute2 man pages.
=46rom there, I can make the old wiki just be a reference to them.
And Michael will pickup the man7.org versions from the current iproute2.

The iproute2 git tree is single source of current documentation please.
