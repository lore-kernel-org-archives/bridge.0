Date: Thu, 19 Jan 2006 20:01:22 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging multiple tap interfaces
Message-ID: <20060119200122.68b89183@localhost.localdomain>
In-Reply-To: <425BE87409B6BA49954C7D375C69F9ED03270833@ms09.mse4.exchange.ms>
References: <425BE87409B6BA49954C7D375C69F9ED03270833@ms09.mse4.exchange.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Elangovan, Anush" <anush@fireeye.com>
Cc: bridge@osdl.org

On Thu, 19 Jan 2006 21:05:01 -0500
"Elangovan, Anush" <anush@fireeye.com> wrote:

> Is it possible to bridge multiple "tap" interfaces in Linux?
> 
> When two tap interfaces are bridged together they are unable to "see"
> each other but they can bridge to external Ethernet interfaces or the
> hosts IP attached on the bridge. 
> 
> I saw some mention in the mailing list archives on bridging two user
> space processes but it didn't seem to have any conclusion. I also
> noticed some other wireless interfaces and tap interfaces are not able
> to be bridged. 
> 
> http://lists.osdl.org/pipermail/bridge/2005-December/001215.html
> 
> 
> So does the bridging code differentiate between the pseudo-devices
> before making forwarding decisions?
> 
> Thanks
> Anush

It could work now, since each tap should have it's own unique source
address. But remember anything being bridge has to "look and feel" like
a standard Ethernet for it to work.  That means broadcast and address
filtering has to work as well.
