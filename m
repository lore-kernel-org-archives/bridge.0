Message-ID: <AD59566A9D83864F871AE2E52503064001663D5C@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: Re: [Bridge] Bridge and PACKET-socket
Date: Mon, 2 Feb 2004 11:50:04 -0500 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@osdl.org'" <bridge@osdl.org>

On Tuesday 13 January 2004 12:41:55 -0800, Bart De Schuymer wrote:
> Reading the man page is indeed confusing for a user, w.r.t. bridge ports.
> I think it would be more logical if all PF_PACKET
> sockets see the frames before the bridge code.

I agree.  I just ran into this problem trying to read bridge PDUs from a
daemon listening on a packet socket.  I'm glad I found this thread; it saved
me a lot of debugging time.

> How about placing the call to __handle_bridge() right after the second 
> list_for_each? If I'm not mistaken the relevant pt_pre->func that would
deal 
> with the packet will not have been executed yet, while those PF_PACKET 
> functions will already have been called...

Has anyone tested this in the two weeks since it was suggested?

-- 
Dan Eble <dane@aiinet.com>  _____  .
                           |  _  |/|
Applied Innovation Inc.    | |_| | |    "All Protocols MUST be odd"
http://www.aiinet.com/     |__/|_|_|      -- RFC 1661 (PPP)
