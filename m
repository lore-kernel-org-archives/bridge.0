From: Ross Vandegrift <ross@kallisti.us>
Date: Wed, 29 Apr 2009 12:53:29 -0400
Message-ID: <20090429165329.GA9893@kallisti.us>
References: <20090428124009.GA26387@kallisti.us>
	<db99f77d0904280552n5717cd86x6cc045a9f64e5a45@mail.gmail.com>
	<20090428133702.GA26738@kallisti.us> <49F73E9A.7090706@gmail.com>
	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>
	<49F77248.1050800@gmail.com>
	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>
	<49F87D4E.4060705@gmail.com> <20090429162651.GA9455@kallisti.us>
	<49F882F9.4010100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49F882F9.4010100@gmail.com>
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
	connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, Apr 29, 2009 at 06:40:25PM +0200, Jochen Hebbrecht wrote:
> Yes, it is plugged in ( Ubuntu says: link is ready ).
> I also tried statically, but no improvements :-( ...

Is your wireless access point also bridging between the wired and the
wireless?  If so, then you have two bridges circulating packets
between the wired and wireless networks.

You should either turn on STP so loops can be detected and prevented
or unplug eth0 to simulate that scenario.

Ross

-- 
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie
