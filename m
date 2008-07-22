Date: Tue, 22 Jul 2008 13:09:26 +0200
From: Adam Osuchowski <Adam.Osuchowski@polsl.pl>
Message-ID: <20080722110926.6b8b4567@polsl.pl>
References: <4865c467.386.27ed.998123722@webmaildh4.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4865c467.386.27ed.998123722@webmaildh4.aruba.it>
Subject: Re: [Bridge] 802.1q packets
Reply-To: Adam Osuchowski <Adam.Osuchowski@polsl.pl>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@osdl.org

Fulvio Ricciardi wrote:
> I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
> tagged packets larger than 1470 bytes are not forwarded at
> all by a bridge.
> I think there is a bad interaction between bridge and
> netfilter codes. Any chance to a have a patch to solve this
> problem that limit the possibility to use the Linux bridges
> in a environment with VLANs?

Is it maybe problem described here?

  https://lists.linux-foundation.org/pipermail/bridge/2007-May/005436.html

If so, it was reported more than one year ago and still none of developers
care about it.

-- 
##  Adam Osuchowski                            Adam.Osuchowski@polsl.pl
##  Silesian University of Technology, Computer Centre, Gliwice, Poland
