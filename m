From: Benny Amorsen <benny+usenet@amorsen.dk>
References: <loom.20110328T194703-472@post.gmane.org>
Date: Wed, 30 Mar 2011 16:46:46 +0200
In-Reply-To: <loom.20110328T194703-472@post.gmane.org> (igor serebryany's
	message of "Mon, 28 Mar 2011 17:54:29 +0000 (UTC)")
Message-ID: <m3y63whdih.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] 802.1q tagging broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: igor serebryany <igor47@moomers.org>
Cc: bridge@osdl.org

igor serebryany <igor47@moomers.org> writes:

> now, i want to assign eth0 to a bridge
>
> brctl addbr xenbr0
> ifconfig xenbr0 up
> brctl addif xenbr0 eth0

I may be misunderstanding your topology, but I would have expected that
you would want to brctl addif xenbr0 eth0.234? It is unusual to bridge
an interface and expect tagged packets to traverse the bridge (typically
done in q-in-q setups).


/Benny
