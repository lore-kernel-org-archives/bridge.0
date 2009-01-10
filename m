From: Ross Vandegrift <ross@kallisti.us>
Date: Fri, 9 Jan 2009 19:27:27 -0500
Message-ID: <20090110002727.GA30394@kallisti.us>
References: <c0bb1def0901091401m6087a122m8ef5ca6bb23eca9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bb1def0901091401m6087a122m8ef5ca6bb23eca9a@mail.gmail.com>
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

On Fri, Jan 09, 2009 at 11:01:19PM +0100, Antonio Di Bacco wrote:
> Does the RSTP will manage to resolve the loop (open the ring)? Will I manage
> to reach anyway the PC?

Probably yes, but the answer could be no.  All the non-STP switches I've
ever seen do forward BPDUs.

Strictly speaking, 802.1D bridges should never forward frames addressed
to the reserved bridge management MAC addresses.  This would lead both
B & C to believe they were connected to an edge port, which will never
block.


-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
