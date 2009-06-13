References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
	<OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
	<1244905945.3175.25.camel@ursa.amorsen.dk>
	<OF6DCC73C6.20F5C539-ONC12575D4.00562ACB-C12575D4.00569683@transmode.se>
	<m3tz2koyvq.fsf@ursa.amorsen.dk>
	<OF0FD1F433.2EE7F805-ONC12575D4.0065DF68-C12575D4.006653AD@transmode.se>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Sat, 13 Jun 2009 20:51:43 +0200
In-Reply-To: <OF0FD1F433.2EE7F805-ONC12575D4.0065DF68-C12575D4.006653AD@transmode.se>
	(Joakim Tjernlund's message of "Sat\,
	13 Jun 2009 20\:37\:41 +0200")
Message-ID: <m3ljnwotkw.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> Oh, I see that it was Ross who made that claim. You don't agree? If so how
> do you explain that is OK to broadcast the same pkg back on that same physical interface?

Why wouldn't it be? If you don't like it you can use ebtables to turn it
off.

So far I haven't seen a real-world use case for NOT passing the packets
out on the same interface (except for the case solved with STP), but I
have seen plenty of real world networks where it was necessary.


/Benny

