Message-ID: <AD59566A9D83864F871AE2E525030640050736@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] Re: ebtables target to disable an interface
Date: Tue, 12 Aug 2003 11:29:27 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: bridge@osdl.org

> You could log the event, and monitor the log with a
> 	tail -f logfile | ...
> to turn it off. No extension needed.
> -- 
> Cameron Simpson <cs@zip.com.au> DoD#743
> http://www.cskk.ezoshosting.com/cs/

I just discovered the iptables ULOG target, which sends packets to user
space through a netlink socket.  I may try to convert it into an ebtables
watcher, but I will experiment with iptables ULOG first, to see how easy it
is to use.

-- 
Dan Eble <dane@aiinet.com>  _____  .
                           |  _  |/|
Applied Innovation Inc.    | |_| | |            "All Protocols MUST be odd"
http://www.aiinet.com/     |__/|_|_|              -- RFC 1661 (PPP)
