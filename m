Return-Path: <zax@zaxnet.org>
Date: Mon, 14 Jan 2019 20:47:55 +0100
From: Zahari Doychev <zax@zaxnet.org>
Message-ID: <20190114194755.GC9540@mail>
References: <20190113135939.8970-1-zahari.doychev@linux.com>
	<62e4c62c-39c0-71d7-99d0-3e51878e2ddc@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e4c62c-39c0-71d7-99d0-3e51878e2ddc@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH 0/2] net: bridge: fix tc added QinQ forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Zahari Doychev <zahari.doychev@linux.com>, jhs@mojatatu.com, johannes@sipsolutions.net

On Mon, Jan 14, 2019 at 01:46:09PM +0200, Nikolay Aleksandrov wrote:
> On 13/01/2019 15:59, Zahari Doychev wrote:

[...]

> 
> How well was this set tested ? It breaks connectivity between bridge and
> members when vlans are used. The host generated packets going out of the bridge
> have mac_len = 0.
> 
> E.g.:
> # tcpdump -e -n -i vnet2
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on vnet2, link-type EN10MB (Ethernet), capture size 262144 bytes
> 17:47:08.824208 00:01:52:54:00:04 > 00:01:08:00:06:04, ethertype 802.1Q (0x8100), length 32: vlan 25, p 0, ethertype 0x5eba, 
> 	0x0000:  c0a8 6401 0000 0000 0000 c0a8 6402       ..d.........d.
> 17:47:09.848492 00:01:52:54:00:04 > 00:01:08:00:06:04, ethertype 802.1Q (0x8100), length 32: vlan 25, p 0, ethertype 0x5eba, 
> 	0x0000:  c0a8 6401 0000 0000 0000 c0a8 6402       ..d.........d.
> 
> Headers are messed up. This is br0 with pvid 25 and vnet2 with vlan 25 tagged.
> You'll probably have to reset mac_len in bridge's xmit function.
> 

Thanks I will look into this. I have done most of tests with PC with two nics
and two other hosts conntected to each of the interfaces.

> The potentially affected cases will need to be carefully considered, as you've noted,
> since this change is dangerous. Please also run all bridge selftests and make sure
> they all pass. Giving more details about which cases you've considered and how
> this set was tested in the commit log would be very helpful.
> 

Thanks for pointing to the selftests. I will run them. These are the tests part
of the kselftest correct?

Regards,
Zahari

> Thanks,
>  Nik
> 
> 
