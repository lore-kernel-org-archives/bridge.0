Message-Id: <46FBE2DD.76E4.0078.0@novell.com>
Date: Thu, 27 Sep 2007 16:05:33 +0100
From: "Jan Beulich" <jbeulich@novell.com>
References: <46FA2C17.76E4.0078.0@novell.com>
	<20070926083705.6bc65ea5@fujitsu-loaner>
	<46FAA013.76E4.0078.0@novell.com>
	<20070926101252.3ccbb987@freepuppy.rosehill>
	<46FB7A7A.76E4.0078.0@novell.com>
	<20070927074849.074fdb88@freepuppy.rosehill>
In-Reply-To: <20070927074849.074fdb88@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges are
	created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

>> >Sounds like a module utilities problem since unloading one module doesn't
>> >normally unload others.
>> 
>> I have to disagree here - 'modprobe -r' is specifically unloading all modules the
>> specified one references as long as they have a use count of zero. The
>> difference to other networking modules is that the latter normally don't export
>> symbols, and hence don't have dependent modules (and thus cannot be
>> subject of implicit unloading). Bridge does have dependents, and hence must
>> avoid implicit unloading by managing its use count.
>
>I want keep the behavior that:
>	modprobe -r bridge
>removes all bridges.  It is too useful and may already be in some user scripts.

So we have an unsolvable problem here then, unless infrastructure gets added
that allows a module to declare itself as not-implicit-unload-safe, forcing
modprobe -r to keep its hands off it. Ugly.

Jan


