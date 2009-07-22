From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Wed, 22 Jul 2009 10:51:14 +0200
Message-ID: <m3fxcpdrst.fsf@ursa.amorsen.dk>
References: <4A6638A5.208@ipfire.org>
	<2e59e6970907211559t1bf1c776r8684d59e98f96069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

"richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:

> I don't think Linux VLAN support provides a way to separate packets
> with _no_ VLAN header onto a virtual interface, but that surely sounds
> useful.

It would be handy if VLAN 0 meant "packets tagged with VLAN 0 + packets
without tags". The VLAN 0 tag is reserved for packets in the native VLAN
which need 802.1p priority.

Then you could bridge eth0.0 and eth0.30 for the desired effect.


/Benny


