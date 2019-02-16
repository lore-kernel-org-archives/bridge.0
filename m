Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:in-reply-to:references:mime-version:content-transfer-encoding
	:subject:to:cc:from:message-id;
	bh=VFWWHOXJNYmVrfGB6C/hxXl37j2MMeoUpcMpaKc6pE0=;
	b=Q8+j6d2ZkW830rYb1vJvk1y3wmRFaSirDcxETGbhpItbO5qKm3GUhGCUWTPvrHxyYh
	TH08hywhGQIxtbz55FgITShifllXFAhmyngm6yvqbIJ8G2pnwFKfAc39UBwaWSCyMfW/
	D7oAsmFVt77HURbK9Xmba9sKHVl2DVP895y3U=
Date: Sat, 16 Feb 2019 21:27:26 +0200
In-Reply-To: <0FE44F84-AD68-4FC0-8FEB-D033CF6159D2@cumulusnetworks.com>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190215171332.GA1472@otheros>
	<479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
	<20190216184353.GA10888@splinter>
	<0FE44F84-AD68-4FC0-8FEB-D033CF6159D2@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <E8A29F94-091F-44CA-9E33-481BF21C359D@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
	traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On 16 February 2019 21:15:21 EET, nikolay@cumulusnetworks=2Ecom wrote:
>On 16 February 2019 20:43:53 EET, Ido Schimmel <idosch@idosch=2Eorg>
>wrote:
>>On Sat, Feb 16, 2019 at 10:05:40AM +0200, Nikolay Aleksandrov wrote:
>>> On 15/02/2019 19:13, Linus L=C3=BCssing wrote:
>>> > On Fri, Feb 15, 2019 at 03:04:27PM +0200, Nikolay Aleksandrov
>>wrote:
>>> >> Every user would expect to have traffic forwarded only to the
>>configured
>>> >> mdb destination when snooping is enabled, instead now to get that
>>one
>>> >> needs to enable both snooping and querier=2E Enabling querier on
>all
>>> >> switches could be problematic and is not a good solution,
>>> >=20
>>> > There is no need to set the querier on all snooping switches=2E
>>> > br_multicast_querier_exists() checks if a querier exists on the
>>> > link in general, not if this particular host/bridge is a querier=2E
>>> >=20
>>>=20
>>> We need a generic solution for the case of existing mdst and no
>>querier=2E
>>> More below=2E
>>>=20
>>> >=20
>>> >> for example as summarized by our multicast experts:
>>> >> "every switch would send an IGMP query
>>> >=20
>>> > What? RFC3810, section 7=2E1 says:
>>> >=20
>>> > "If it is the case, a querier election mechanism (described in
>>> >  section 7=2E6=2E2) is used to elect a single multicast router to be
>>> >  in Querier state=2E [=2E=2E=2E] Nevertheless, it is only the [elect=
ed]
>>Querier
>>> >  that sends periodical or triggered query messages on the subnet=2E"
>>> > >> for any random multicast traffic it
>>> >> received across the entire domain and it would send it forever as
>>long as a
>>> >> host exists wanting that stream even if it has no
>>downstream/directly
>>> >> connected receivers"
>>> >=20
>>>=20
>>> This was taken out of context and it's my bad, I think everyone is
>>aware
>>> of the election process, please nevermind the above statement=2E
>>>=20
>>> [snip]>=20
>>> >=20
>>> > Have you done some tests with this change yet, Nikolay?
>>> >=20
>>>=20
>>> You've raised good questions, IPv6 indeed needs more work - we'll
>>have to flood
>>> link-local packets etc=2E but I wanted to have a discussion about no
>>querier/existing mdst=2E
>>> To simplify we can modify the patch and have traffic forwarded to
>the
>>proper ports when an
>>> mdst exists and there is no querier for both unsolicited report and
>>user-added entry=2E
>>> We can keep the current behaviour for unknown traffic with and
>>without querier=2E
>>> This would align it closer to what other vendors currently do as
>well
>>IIRC=2E
>>> What do you think ?
>>
>>The no querier condition is not currently reflected via switchdev, so
>>the behavior you're proposing in your patch is what actually happens
>in
>>the data plane=2E
>>
>>We already hit the problem Linus mentioned in commit b00589af3b04
>>("bridge: disable snooping if there is no querier")=2E Namely, IPv6 ND
>>broke because a port joined before the bridge was created=2E
>>
>>I introduced a workaround in commit 9d45deb04c59 ("mlxsw: spectrum:
>>Treat IPv6 unregistered multicast as broadcast")=2E I'm interested to
>>know
>>what other vendors are doing=2E Can you elaborate?
>>
>
>Exactly like your fix=2E :) Flood it, this patch unfortunately breaks it=
=C2=A0
>because of mrouters flag, but we can retain the behaviour
>by forwarding only known mdsts to their ports and flooding
>unregistered mcast when there is no querier=2E I think that is=20
>what others do by default too, actually I think they flood with querier
>as well=2E Maybe unknown mcast flooding should be controlled by a flag
>when a querier is present
>because we've had this behaviour for a long time, personally I'd have
>it on
>by default=2E=20

Ugh, mispoke please read the above statement to be only about no querier=
=2E=20
I meant flooding v6 link-local always=2E=20

>I am currently away and will be able to prepare a rfc patch after the
>weekend=2E=20
>
>
>>We can trap IPv6 ND packets at L2 (we'll eventually need to do for ND
>>suppression) and let the bridge take care of flooding them correctly=2E
>>I'm not sure it's good enough=2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
