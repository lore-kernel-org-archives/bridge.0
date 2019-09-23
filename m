Return-Path: <ikalvachev@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=rs2RJDT5CsHbbEtk6Tq8OPTXVr0+QPsaOdJbfaooK0s=;
	b=aj0n9SYvFIYCRxpn20Jz+FRTJT0KI+N5uVRMrxxEpuhyjLbdEoS1G9UzMTavhqTMWL
	1LCe2i8i2ERqrH2v8e+Br3FQO+eO6jERm2FkKcW6wPK0ChFI2+XTooznTacB4rvoJzbJ
	EwL2dOAquvmqhdDCmqLqSIMqII9gJxgpCwt4zV/JvI+xFOKzoT9d2Gxer0x6aoxYbYFw
	PfcImqKzbV6AYykpbw9rwmP+G5tfi1N5t8tyx5ueI1CdVQ14TsY2lS6yEO5k5j41/Gpy
	JPpOQXcdiOsRx8HloPeT68q5AHuowfy7lgwJaRyrfeF0Jdy0vCjpTW0WM1crdjdZ7sIC
	OJgQ==
MIME-Version: 1.0
In-Reply-To: <20190807155738.GA9394@azazel.net>
References: <20190807183606.372ca1a4@canb.auug.org.au>
	<f54391d9-6259-d08b-8b5f-c844093071d8@infradead.org>
	<20190807155738.GA9394@azazel.net>
From: Ivan Kalvachev <ikalvachev@gmail.com>
Date: Tue, 24 Sep 2019 01:26:22 +0300
Message-ID: <CABA=pqeES0C2+7GpAOYuCOqd5DrbZhjS1Tkrxn4kGxXQJkrAfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] linux-next: Tree for Aug 7
	(net/bridge/netfilter/nf_conntrack_bridge.c)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jeremy Sowden <jeremy@azazel.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Randy Dunlap <rdunlap@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>

On 8/7/19, Jeremy Sowden <jeremy@azazel.net> wrote:
> On 2019-08-07, at 08:29:44 -0700, Randy Dunlap wrote:
>> On 8/7/19 1:36 AM, Stephen Rothwell wrote:
>> > Hi all,
>> >
>> > Changes since 20190806:
>>
>> on i386:
>> when CONFIG_NF_TABLES is not set/enabled:
>>
>>   CC      net/bridge/netfilter/nf_conntrack_bridge.o
>> In file included from
>> ../net/bridge/netfilter/nf_conntrack_bridge.c:21:0:
>> ../include/net/netfilter/nf_tables.h: In function
>> =E2=80=98nft_gencursor_next=E2=80=99:
>> ../include/net/netfilter/nf_tables.h:1224:14: error: =E2=80=98const stru=
ct
>> net=E2=80=99 has no member named =E2=80=98nft=E2=80=99; did you mean =E2=
=80=98nf=E2=80=99?
>>   return net->nft.gencursor + 1 =3D=3D 1 ? 1 : 0;
>>               ^~~
>
> I've just posted a series of fixes for netfilter header compilation
> failures, and I think it includes the fix for that:
>
>
> https://lore.kernel.org/netdev/20190807141705.4864-5-jeremy@azazel.net/T/=
#u

Have these patches been committed?

I just hit the same bug in linux-5.3.1 release.
