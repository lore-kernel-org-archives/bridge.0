Date: Fri, 26 Jan 2007 21:09:47 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070126210947.75c55177@localhost.localdomain>
In-Reply-To: <1169857805.28708.1.camel@linux-2n2q.site>
References: <1169857805.28708.1.camel@linux-2n2q.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Clear a mac from table?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Brad Dameron <brad.dameron@clearwire.com>
Cc: bridge@lists.osdl.org

On Fri, 26 Jan 2007 16:30:05 -0800
Brad Dameron <brad.dameron@clearwire.com> wrote:

> 
> Anyone know of a way to clear a mac from the bridge hash table instead
> of waiting for it to expire? This would be handy with pushing people
> between vlans that are on the same switch.

No API exists but the first transmit (gratuitous ARP?) would
move the entry.
