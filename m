From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Wed, 07 May 2008 12:42:04 +0200
Message-ID: <m363tq2y6b.fsf@ursa.amorsen.dk>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> If I loop two or more interfaces by connecting each interface's output
> to its own input, I get a loop that STP doesn't detect.
> Looping by connecting an output from one interface to another interface
> input works fine.

Do you see BPDU packets come back when you do the loops? tcpdump can
probably help. It sounds like the switch is eating your BPDU's.


/Benny


