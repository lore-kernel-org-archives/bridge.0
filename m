Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 12 Mar 2018 12:48:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180312114815.GN2470@otheros>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<20180312110856.GL2470@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180312110856.GL2470@otheros>
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
Cc: "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

On Mon, Mar 12, 2018 at 12:08:56PM +0100, Linus Lüssing wrote:
> On Tue, Feb 27, 2018 at 11:08:20AM +0100, Rafał Miłecki wrote:
> > I've problem when using OpenWrt/LEDE on a home router with Broadcom's
> > FullMAC WiFi chipset.
> 
> Hi Rafał,
> 
> Thanks for reporting this issue!
> 
> > Can you see any solution for this problem? Is that an option to stop
> > multicast-to-unicast from touching 802.11f packets? Some other ideas?
> > Obviously I can't modify Broadcom's firmware and drop that obsoleted
> > standard.
> 
> Just to avoid some potential confusion: This is more an issue of
> hairpinning than it is an issue of multicast-to-unicast per se,
> right?
> 
> That is, if you set this to 0 manually:
> /sys/class/net/<ap-iface>/brport/multicast_to_unicast
> Then the issue still occurs, right?

Btw., if in OpenWRT/LEDE you set 'option multicast_to_unicast 0'
in /etc/config/network for the bridge (and not bridge port)
then netifd should refrain from setting the bridge hairpinning and
AP isolation on wireless devices, too, if I remember correctly.

Can you confirm that the issue disappears for you then?
