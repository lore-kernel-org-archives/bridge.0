Date: Tue, 27 Jan 2004 16:08:43 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] forwarding delay
Message-Id: <20040127160843.1569107c.shemminger@osdl.org>
In-Reply-To: <4016B8E3.6050701@draigBrady.com>
References: <4016B8E3.6050701@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: P@draigBrady.com
Cc: bridge@osdl.org

On Tue, 27 Jan 2004 19:15:47 +0000
P@draigBrady.com wrote:

> Hi,
> 
> I'm using linux 2.4.20 here and noticed that even
> when STP is disabled for a bridge, the forwarding delay
> still takes affect. Is this correct? I.E. Does the
> bridge need to spend time in the "listening" and
> "learning" states when STP isn't used?
> 
> It's an easy work around to set the delay to 0,
> I'm just wondering whether it's a buglet or
> by design.

I think it was a design decision to avoid forwarding data until
some state was acquired.  It is annoying if you don't expect it.
