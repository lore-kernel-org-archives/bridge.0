From: Bart De Schuymer <bdschuym@pandora.be>
Date: Thu, 19 Aug 2004 20:10:28 +0200
References: <411EAF08.3000401@shorewall.net> <411F7B87.7060303@shorewall.net>
	<41200E80.2000005@trash.net>
In-Reply-To: <41200E80.2000005@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408192010.28417.bdschuym@pandora.be>
Subject: [Bridge] Re: Policy match with a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>, Tom Eastep <teastep@shorewall.net>
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org

On Monday 16 August 2004 03:31, Patrick McHardy wrote:
> The problem is ipv4_sabotage_out in the briding code. It prevents the
> packet from hitting the LOCAL_OUT hook while it is still unencrypted.
> When it hits the bridging code and its LOCAL_OUT hook it's too late.
> Not sure how to handle it yet.

I'll have a look at that after I'm finished with the IPv6 bridge firewalling 
stuff.

cheers,
Bart

