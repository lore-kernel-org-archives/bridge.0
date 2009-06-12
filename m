References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Fri, 12 Jun 2009 11:17:45 +0200
In-Reply-To: <de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	(Daniel Robbins's message of "Thu\, 11 Jun 2009 13\:51\:06 -0600")
Message-ID: <m33aa5bykm.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Joakim Tjernlund <joakim.tjernlund@transmode.se>

Daniel Robbins <drobbins@funtoo.org> writes:

> In particular, I think this could be *very* useful for virtualization,
> where you are adding/removing interfaces from the bridge often. Why?
> Because it eliminates the need to dynamically create/remove ebtables
> rules and keep them in sync with the interfaces on the bridge.

If you had sets of interfaces, like you can have sets of ip addresses
today, it would be trivial to keep the sets in sync.

I don't find it particularly as it is, but with interface-sets you
wouldn't even have to change any rules.


/Benny

