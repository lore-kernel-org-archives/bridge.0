Date: Sun, 15 Feb 2004 13:02:54 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
Subject: Re: [Bridge] maximum throughput for linux bridge
Message-ID: <20040215120254.GA13054@gareth.mathematik.tu-chemnitz.de>
References: <1076657825.735.72.camel@amidala.mozcom.com>
	<402D1112.4040902@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D1112.4040902@osdl.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, "Paul P. Pongco" <paulp@mozcom.com>, bridge@osdl.org

On Fri, Feb 13, 2004 at 10:01:54AM -0800 or thereabouts, Stephen Hemminger wrote:
> 
> The problem is that the 3c905 cards don't support interrupt mitigation, 
> so when lots
> of network traffic hits, they drop data.  The 3c59x driver allocates and 
> copies every
> received frame in the interrupt routine.  What is needed is a new driver 
> that does NAPI
> (any volunteers)? 
> 

Is seems that it is not possible to get the technical reference
for the 3c905 cards from the 3com webpage any more.
Filling out the cgi form at 
http://support.3com.com/partners/developer/developer_form.html
will leed to a server error.
