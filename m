From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 24 Aug 2006 22:17:11 +0200
Message-ID: <m3u041yjlk.fsf@ursa.amorsen.dk>
References: <44EDE259.4050009@dotr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Re: [Bridge] transparent bridge and proxies
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "JL-S" == Julian Lyndon-Smith <asterisk@dotr.com> writes:

JL-S> So, I changed the ip address to 0.0.0.0. Everything except squid
JL-S> still worked. I presume that's because it does not know how to
JL-S> route the data to get stuff.

JL-S> Can I add a rule to iptables or something to say "anything
JL-S> that's come from eth1 into the local box, after processing send
JL-S> to eth0" and vice-versa ?

How about using 127.0.0.1 or something else on the local subnet?
iptables should be able to redirect to that.

I don't know how you'll get traffic from squid out of the box though.
If you know a way to make squid reuse the original clients address in
the outgoing connection, I'm all ears.


/Benny


