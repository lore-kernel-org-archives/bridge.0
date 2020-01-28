Return-Path: <J.Lambrecht@TELEVIC.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=televic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hP7bh6/USdKlEIf1iYj5wl/My/uWSKPZYQVGiy6lOU=;
 b=EKbvIpKwRFnrquktAaU/1L6PolaVrC4vJJmOsGoZ2GfwZyRCRkPH8cdckjBH3zOuDfwe6l0lNsC3WECSHE15uxx/T9GZQ3N4KwyWgGwoc0I2DKTC2Q9cbcor0sLdzkbHm6PRr0BzUa8X4uvm+OFW6XmbsHR9hOoYXmJjhUaZ7PY=
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124203406.2ci7w3w6zzj6yibz@lx-anielsen.microsemi.net>
 <87zhecimza.fsf@linux.intel.com>
 <20200125094441.kgbw7rdkuleqn23a@lx-anielsen.microsemi.net>
 <87imkz1bhq.fsf@intel.com>
From: =?UTF-8?Q?J=c3=bcrgen_Lambrecht?= <j.lambrecht@televic.com>
Message-ID: <83f98a49-d5b6-c5d8-9ca3-4c5eea8fb312@televic.com>
Date: Tue, 28 Jan 2020 11:35:34 +0100
In-Reply-To: <87imkz1bhq.fsf@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC net-next v3 00/10] net: bridge: mrp: Add support
 for Media Redundancy Protocol (MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 1/25/20 10:18 PM, Vinicius Costa Gomes wrote:
> CAUTION: This Email originated from outside Televic. Do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>
>
> Hi,
>
> "Allan W. Nielsen" <allan.nielsen@microchip.com> writes:
>
>> Hi Vinicius,
>>
>> On 24.01.2020 13:05, Vinicius Costa Gomes wrote:
>>> I have one idea and one question.
>> Let me answer the question before dicussing the idea.
>>
>>> The question that I have is: what's the relation of IEC 62439-2 to IEEE
>>> 802.1CB?
>> HSR and 802.1CB (often called FRER - Frame Replication and Elimination
>> for Reliability) shares a lot of functionallity. It is a while since I
>> read the 802.1CB standard, and I have only skimmed the HSR standard, but
>> as far as I understand 802.1CB is a super set of HSR. Also, I have not
>> studdied the HSR implementation.
>> Both HSR and 802.1CB replicate the frame and eliminate the additional
>> copies. If just 1 of the replicated fraems arrives, then higher layer
>> applications will not see any traffic lose.
>>
>> MRP is different, it is a ring protocol, much more like ERPS defined in
>> G.8032 by ITU. Also, MRP only make sense in switches, it does not make
>> sense in a host (like HSR does).
>>
>> [snip MPR explanation]
>>
>> Sorry for the long explanation, but it is important to understand this
>> when discussion the design.
> Not at all, thanks a lot. Now it's clear to me that MRP and 802.1CB are
> really different beasts, with different use cases/limitations:
>
>  - MRP: now that we have a ring, let's break the loop, and use the
>    redudancy provided by the ring to detect the problem and "repair" the
>    network if something bad happens;
indeed. MRP is IEC 62439-2
>
>  - 802.1CB: now that we have a ring, let's send packets through
>    two different paths, and find a way to discard duplicated ones, so
>    even if something bad happens the packet will reach its destination;

Not exactly, 802.1CB is independent of the network layout, according to the=
 abstract on https://ieeexplore.ieee.org/document/8091139.

The IEC 62439-3 standard mentions 2 network layouts: 2 parallel paths and a=
 ring:

- IEC 62439-3.4 Parallel Redundancy Protocol (PRP): this runs on 2 separate=
d parallel paths in the network

- IEC 62439-3.5 HSR (High availability seamless redundancy): this runs on a=
 ring: each host sends all data in 2 directions, and when it receives its o=
wn data back, it discards it (to avoid a loop).

(and it is better to implement IEEE, because the standard costs only 151$, =
and the IEC ones cost 2x410$)

Kind regards,

J=FCrgen

