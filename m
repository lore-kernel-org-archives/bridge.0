Message-Id: <200501290210.j0T2AouM013154@smtp.osdl.org>
From: "Dan Grigsby" <dan@unpossible.com>
Subject: RE: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Date: Fri, 28 Jan 2005 20:10:50 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050128152333.5e718a26@dxpl.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Stephen Hemminger' <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

> Please try this patch,  it does:
>	* don't spin_lock on the update path unless entry
>	  is missing
>	* increase size of hash table
>	* use jenkins hash which might distribute better
>	* run gc timer at fixed interval.

I'll build a new kernel and let you know.  Thanks.

I've been working through the code and feel like I'm getting the feel of it.
The key was the NF_HOOK macro.

It's been ages since I wrote my own hash algorithm, so forgive a dumb
question: will a larger hash perform faster?  I only have a handful of mac
addresses to hash.  For me, ultimately this will be limited to 4 macs, one
for each interface and one for the single device attached to each Ethernet
segment.


