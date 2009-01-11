References: <c0bb1def0901091401m6087a122m8ef5ca6bb23eca9a@mail.gmail.com>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Sun, 11 Jan 2009 01:11:13 +0100
In-Reply-To: <c0bb1def0901091401m6087a122m8ef5ca6bb23eca9a@mail.gmail.com>
	(Antonio Di Bacco's message of "Fri\,
	9 Jan 2009 23\:01\:19 +0100")
Message-ID: <m3bpue3dni.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] Network with some switches without STP/RSTP support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Antonio Di Bacco <a.dibacco@gmail.com>
Cc: bridge <bridge@lists.linux-foundation.org>

"Antonio Di Bacco" <a.dibacco@gmail.com> writes:

> Does the RSTP will manage to resolve the loop (open the ring)? Will I
> manage to reach anyway the PC?

If you have connections A <=> B, B <=> C, C <=> A then you'll have to
be very careful with your configuration if you want to ensure that the
link B <=> C isn't picked as the one to block. I would strongly
recommend that you don't make a topology that only works if certain
links are never blocked.

The best way to have that level of control is to disable spanning tree
and do the blocking/unblocking manually.


/Benny

