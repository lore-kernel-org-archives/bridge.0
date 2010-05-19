Message-ID: <4BF46C74.9000000@superduper.net>
Date: Wed, 19 May 2010 15:55:48 -0700
From: Simon Barber <simon@superduper.net>
MIME-Version: 1.0
References: <20100518165112.18669700@nehalam>	<F24C979D1AFD4E4292B911441CBA242407FCC8@2putt.int.lantronix.com>
	<20100519192011.GJ2412@tuxdriver.com>
	<4BF4512C.4040903@superduper.net>
	<F24C979D1AFD4E4292B911441CBA242407FCCA@2putt.int.lantronix.com>
In-Reply-To: <F24C979D1AFD4E4292B911441CBA242407FCCA@2putt.int.lantronix.com>
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
To: Umar Qureshey <umar.qureshey@lantronix.com>
Cc: bridge@lists.linux-foundation.org

The problem is not the WiFi chipset - it's the IEEE802.11 standard. The 
standard does not allow for 'promiscuous mode' (not to be confused with 
monitor mode), nor does it require clients and access points to support 
4 address format frames which the bridge needs to work.

Simon

On 05/19/2010 02:08 PM, Umar Qureshey wrote:
>>> -----Original Message-----
>>> From: Simon Barber [mailto:simon@superduper.net]
>>> Sent: Wednesday, May 19, 2010 1:59 PM
>>> To: John W. Linville
>>> Cc: Umar Qureshey; bridge@lists.linux-foundation.org
>>> Subject: Re: [Bridge] Hardware requirements for bridging
> wired+wireless together
>>>
>>> I did write an ebtables module to work around this 802.11 3 address
>>> problem - it performed L2 NAT on DHCP, ARP and IP packets, so
> allowing
>>> an 802.11 client be added to a bridge. It was released under GPL
> about 5
>>> years ago (from my previous company Instant802/Devicescape), but I
> can't
>>> find the source anymore!!!
>>>
>>> Simon
>
> That would be very useful.  Probably even more useful now than 5 years
> ago!  Apparently, Windows does MAC-level NAT allowing for the bridging
> of Ethernet and WiFi interfaces irrespective of the underlying Wifi
> chipset.
>
> **********************************************************************
> This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited.
