Date: Tue, 20 May 2008 00:12:52 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <4831D97F.1010907@free.fr>
Message-ID: <alpine.DEB.1.00.0805200009020.6633@pandora.retrosnub.co.uk>
References: <4831D97F.1010907@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] bridge protocol family
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benoit PAPILLAULT <benoit.papillault@free.fr>
Cc: bridge@lists.linux-foundation.org

At 21:48 yesterday, Benoit PAPILLAULT wrote:

> I'm new at layer2 and I've read 802.1D-2004, learning STP and RSTP. I'd
> like to know if there are some other protocols (be it standard or
> proprietary) that achieve this goal of connecting layer2 cloud. Is there
> a concept of routing table at layer2?

This is somewhat off-topic for the list but I'll answer anyway...

Most existing layer 2 protocols don't do routing.  The closest thing an 
Ethernet switch/bridge has to a routing table is the MAC address table, 
indicating on which port a particular host can be found.

There have been efforts to add IP-style routing to layer 2 (Rbridges etc., 
and indeed my own work which is yet to be published) but they're not in 
common use and were never adopted as standards.

If you're interested in this topic, I suggest we continue this discussion 
off-list.

Malcolm

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

