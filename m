From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Wed, 07 May 2008 12:40:53 +0200
Message-ID: <m3abj22y8a.fsf@ursa.amorsen.dk>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<1210152782.4861.6.camel@blas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Jaime Nebrera <jnebrera@eneotecnologia.com> writes:

>   Hi Joakim,
>
>   I'm not aware if Linux bridge is aware of this. I can tell you that in
> general, STP has problems when mixed with VLANs.
>
>   To solve this some extensions have arised: PVST by Cisco, MSTP, an
> improvement more or less estandarized and PVST+, a new update only
> available in Cisco environments.
>
>   In general they run multiple "STP" instances per VLAN or VLAN group.

PVST+ simply tags the STP packets. It's the obvious, stupid, and
correct solution. It's the same thing Linux does when you bridge
eth0.1 with eth0.2. Of course Cisco had to change the STP packets just
enough that Linux doesn't interoperate by default.


/Benny


