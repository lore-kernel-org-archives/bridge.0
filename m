Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=/F3EpuLwl1j5GcM8ygDsgActaC8NVviNcH0Fj8PjEp0=;
	b=ZPctnP28V+2Ga5QKVP8hYAU1+YpdyQTDTmOFDb/mtEPzFWTwpKUFvrw+SH0vLumqAU
	NTj/+DTDv3cxReQzHVvn71T8OHe2IyVTkxxRAAMmesE0/LQoijdq8cM+sGmNwDdXG9Um
	+RW/nj9C+XKqTkJiJ7hI5osAzU3OotLPr20BA=
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
In-Reply-To: <20150825.230641.773630246486190390.davem@davemloft.net>
Date: Wed, 26 Aug 2015 04:33:43 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB16F445-DCA7-437E-B6E1-B70FDC63E55A@cumulusnetworks.com>
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>
	<20150825.194222.390859854071446877.davem@davemloft.net>
	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
	<20150825.230641.773630246486190390.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, wkok@cumulusnetworks.com


> On Aug 25, 2015, at 11:06 PM, David Miller <davem@davemloft.net> =
wrote:
>=20
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Tue, 25 Aug 2015 22:28:16 -0700
>=20
>> Certainly, that should be done and I will look into it, but the
>> essence of this patch is a bit different. The problem here is not
>> the size of the fdb entries, it=E2=80=99s more the number of them - =
having
>> 96000 entries (even if they were 1 byte ones) is just way too much
>> especially when the fdb hash size is small and static. We could work
>> on making it dynamic though, but still these type of local entries
>> per vlan per port can easily be avoided with this option.
>=20
> 96000 bits can be stored in 12k.  Get where I'm going with this?
>=20
> Look at the problem sideways.

Oh okay, I misunderstood your previous comment. I=E2=80=99ll look into =
that.

Thanks,
 Nik=
