Return-Path: <thomas@glanzmann.de>
Date: Thu, 5 Dec 2013 18:27:51 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
Message-ID: <20131205172751.GA9778@glanzmann.de>
References: <20131130085440.GA11638@glanzmann.de>
	<20131205090947.364e30d7@nehalam.linuxnetplumber.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131205090947.364e30d7@nehalam.linuxnetplumber.net>
Subject: Re: [Bridge] Packet reflection breaks Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: gernoth@cs.fau.de, bridge@lists.linux-foundation.org

Hello Stephan,

> Bridging doesn't like loops, and you have created a loop.

I agree. It was actually a Microsoft Load Balancing cluster that created
the loop. Michael told me that the physical switch works because it:

        a) broadcasts
        b) sends it to both ports.

> If you are goin to mess around using ebtables, just write another rule
> to drop the reflections.

Michael said that ebtables only after the bridge has seen the packets
and so is not applicable. Is that true? So should I use arptables. I
tried to block the looped packages by:

        - iptables
        - arptables
        - eptables

But somehow I never made it. Do you have an example for me or can tell
me which of the 3 tools should work, so that I can try again. The NATing
fought the symptoms of my problem.

Cheers,
        Thomas
