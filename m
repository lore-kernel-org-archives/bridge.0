Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 12 Mar 2018 12:40:17 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180312114017.GM2470@otheros>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<20180227090556.02a24a0d@xeon-e3>
	<CACna6rxP4ATE2f6XJi7XKDLe2L_Z43aLreEHDCfGicksYTb0xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rxP4ATE2f6XJi7XKDLe2L_Z43aLreEHDCfGicksYTb0xg@mail.gmail.com>
Subject: Re: [Bridge] Problem with bridge (mcast-to-ucast + hairpin) and
 Broadcom's 802.11f in their FullMAC fw
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On Mon, Mar 12, 2018 at 10:46:45AM +0100, Rafał Miłecki wrote:
> On 27 February 2018 at 18:05, Stephen Hemminger
[...]
> > ebtables is your friend in dealing with weird and broken devices.
> 
> It may be weird, not sure if actually broken. Anyway I'd like to have
> some generic solution instead of telling every user to use ebtables to
> workaround the problem.

I agree that a "broken by default" in OpenWRT/LEDE for a variety
of Broadcom devices is not really acceptable.

Technically we could teach netifd in OpenWRT/LEDE to configure
ebtables accordingly, at least for a list of affected devices,
so that users would not have to. However, as ebtables is not
managed by the fw3 in OpenWRT/LEDE, that would probably interfer
with user provided ebtables rules and scripts...


> That said I think we still should look for a solution for existing
> firmwares. I guess it may takes months to years to never to release
> new firmwares for all supported chipsets.

Hm, we could change the default in OpenWRT/LEDE for
multicast-to-unicast (or more precisely bridge hairpinning) to
disabled again for now.
