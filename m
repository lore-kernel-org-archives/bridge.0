From: Jason Lunz <lunz@falooley.org>
Date: Fri, 30 Apr 2004 01:13:48 +0000 (UTC)
Message-ID: <slrnc93a2k.tob.lunz@orr.homenet>
References: <1083253016.24333.39.camel@scaramouche>
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: NAT on a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

t.luettgert@pressestimmen.de said:
> I can't get "invisible" NAT on a bridge to work.  What I wanted to do
> is redirecting HTTP requests to another machine (or the same machine,
> that'd be good enough, too).

I'm trying to get something like this to work too, but haven't come to
any firm conclusion.

All I've been able to determine so far is that the DNAT won't work
unless there's an IP on the bridge. Have you been seeing warnings in
dmesg about turning on ip_forwarding?

Jason

