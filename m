Message-ID: <4BF4512C.4040903@superduper.net>
Date: Wed, 19 May 2010 13:59:24 -0700
From: Simon Barber <simon@superduper.net>
MIME-Version: 1.0
References: <20100518165112.18669700@nehalam>	<F24C979D1AFD4E4292B911441CBA242407FCC8@2putt.int.lantronix.com>
	<20100519192011.GJ2412@tuxdriver.com>
In-Reply-To: <20100519192011.GJ2412@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Hardware requirements for bridging wired+wireless
	together
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: bridge@lists.linux-foundation.org, Umar Qureshey <umar.qureshey@lantronix.com>

I did write an ebtables module to work around this 802.11 3 address 
problem - it performed L2 NAT on DHCP, ARP and IP packets, so allowing 
an 802.11 client be added to a bridge. It was released under GPL about 5 
years ago (from my previous company Instant802/Devicescape), but I can't 
find the source anymore!!!

Simon


On 05/19/2010 12:20 PM, John W. Linville wrote:
> On Wed, May 19, 2010 at 10:15:35AM -0700, Umar Qureshey wrote:
>
>> What about bridging in Ad-Hoc mode?  Would that technically work?
>
> No.
>
>> I guess what I am trying to figure out is why bridging would work in WDS mode?  What is it about that mode that allows bridging to work?
>
> It has to do with the MAC-layer addressing on wireless LANs.  Wireless
> frames can use 2, 3, or 4 MAC addresses to identify the transmitter,
> receiver, sender, and destination.  For most frames and most modes,
> 3 MAC addresses are used.  The FromDS and ToDS bits in the header
> are used to allow one of the MAC address fields to specify either
> the transmitter and sender or the destination and receiver.  This is
> sufficient for non-bridged cases since the wireless station is either
> an endpoint of the communication or possibly a router (and therefore
> a Layer-2 endpoint).
>
> WDS (or 4 address) mode removes this limitation by using 4 MAC
> addresses to identify all 4 roles independently.  So, the wireless
> station is able to forward frames received off the air to the
> appropriate destination with the correct sender information intact.
>
> mac80211-based devices can have interfaces created with support for
> 4 address mode using the iw command.  For this to work, your AP has
> to be willing to accept and forward those frames appropriately --
> some do, others don't.  This is only supported for "managed" mode
> interfaces AFAIK.
>
>> If one were to try to modify the kernel code to allow MAC-level NAT, which area of the kernel code would one look at?
>
> netfilter -- I thought there was already some ebtables code to
> do this...?
>
> John
